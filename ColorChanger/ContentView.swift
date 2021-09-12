//
//  ContentView.swift
//  ColorChanger
//
//  Created by slava on 11.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State var redColor: Double = 0.5
    @State var greenColor: Double = 0.5
    @State var blueColor: Double = 0.5
    
    
    var body: some View {
        
        ZStack {
            Color(red: 0.0, green: 0.3, blue: 0.7)
                .ignoresSafeArea()
            VStack{
                ColorView(redColor: redColor, greenColor: greenColor, blueColor: blueColor)
                ColorSlider(colorType: .red, colorValue: $redColor)
                ColorSlider(colorType: .green, colorValue: $greenColor)
                ColorSlider(colorType: .blue, colorValue: $blueColor)
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
