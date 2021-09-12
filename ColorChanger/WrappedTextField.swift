//
//  WrappedTextField.swift
//  ColorChanger
//
//  Created by slava on 12.09.2021.
//

import SwiftUI

struct WrappedTextField: UIViewRepresentable {
    @Binding var colorValue: Double
    
    
    typealias UIViewType = UITextField
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.addDoneButtonOnKeyboard()
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = String(colorValue.rounded(toPlaces: 3))
        updateTextField(textField: uiView)
    }
    
    func updateTextField(textField: UITextField) {
        guard let text = textField.text else { return }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        // delegate methods...
    }
    
    
}


extension UITextField {
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    
    @objc func doneButtonAction() {
        
        self.resignFirstResponder()
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
