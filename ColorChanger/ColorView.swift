//
//  ColorView.swift
//  ColorChanger
//
//  Created by slava on 11.09.2021.
//

import SwiftUI

struct ColorView: View {
    let redColor: Double
    let greenColor: Double
    let blueColor: Double
    
    var body: some View {
        Color(red: redColor, green: greenColor, blue: blueColor)
            .frame(height: 100)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 3))
            .padding()
            
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView(redColor: 0, greenColor: 0, blueColor: 0)
    }
}
