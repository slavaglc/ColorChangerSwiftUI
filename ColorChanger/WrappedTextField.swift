//
//  WrappedTextField.swift
//  ColorChanger
//
//  Created by slava on 12.09.2021.
//

import SwiftUI

struct WrappedTextField: UIViewRepresentable {
    @Binding var colorValue: Double
    @Binding var alertPresented: Bool
    @Binding var error: Text?
    
    typealias UIViewType = UITextField
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.addDoneButtonOnKeyboard(toCoordinator: context.coordinator)
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = String(colorValue.rounded(toPlaces: 3))
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
}

final class Coordinator: NSObject, UITextFieldDelegate {
    let wrappedTextField: WrappedTextField
    var currentTextField: UITextField?
    
    init(_ wrappedTextField: WrappedTextField) {
        self.wrappedTextField = wrappedTextField
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        currentTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currentTextField = textField
        doneButtonAction()
        return true
    }
    
    @objc func doneButtonAction() {
        guard let textField = currentTextField else { return }
        guard let text = textField.text else { return }
        textField.resignFirstResponder()
        guard text != "" else {
            wrappedTextField.alertPresented = true
            wrappedTextField.error = Text("Please, type value")
            return
        }
        guard let value = Double(text) else {
            wrappedTextField.alertPresented = true
            wrappedTextField.error = Text("Please use only digits")
            return
        }
        guard value <= 1 && value >= 0 else {
            wrappedTextField.alertPresented = true
            wrappedTextField.error = Text("Type count between 0 and 1")
            return
        }
        wrappedTextField.colorValue = value
    }


}

extension UITextField: UITextFieldDelegate {
    
    func addDoneButtonOnKeyboard(toCoordinator coordinator: Coordinator) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: coordinator, action: #selector(coordinator.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
