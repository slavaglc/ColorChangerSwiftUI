//
//  ColorSlider.swift
//  ColorChanger
//
//  Created by slava on 11.09.2021.
//

import SwiftUI

struct ColorSlider: View {
    let colorType: Color
   @Binding var colorValue: Double
    var body: some View {
        HStack {
            Slider(value: $colorValue)
                .accentColor(colorType)
            TextField("\(colorType.description)", value: $colorValue, formatter: NumberFormatter.decimal)
                .bordered()
                .frame(width: 65)
                .multilineTextAlignment(.center)
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

extension NumberFormatter {
    static var decimal: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 3
            formatter.numberStyle = .decimal
            return formatter
        }
}

extension TextField {
    func bordered() -> some View {
        ModifiedContent(content: self, modifier: BorderViewModifier())
    }
}
