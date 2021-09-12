//
//  ColorSlider.swift
//  ColorChanger
//
//  Created by slava on 11.09.2021.
//

import SwiftUI

struct ColorSlider: View {
    @State var alertPresented = false
    @State var error: Text? = nil
    
    let colorType: Color
    @Binding var colorValue: Double
    
    var body: some View {
        HStack {
            Slider(value: $colorValue)
                .accentColor(colorType)
            WrappedTextField(colorValue: $colorValue, alertPresented: $alertPresented, error: $error)
                .bordered()
                .frame(width: 65, height: 40)
                .alert(isPresented: $alertPresented, content: {
                    Alert(title: Text("Wrong!"), message: error)
                })
        }
        .padding()
    }
}

struct BorderViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black))
                        .background(RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.white))
                        
                            
    }
}


extension WrappedTextField {
    func bordered() -> some View {
        ModifiedContent(content: self, modifier: BorderViewModifier())
    }
}
