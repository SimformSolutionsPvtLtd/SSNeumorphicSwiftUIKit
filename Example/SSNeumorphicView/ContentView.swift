//
//  ContentView.swift
//  SSNeumorphicView
//
//  Created by Parth Dumaswala on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var strPassword: String = ""
    
    var body: some View {
        return ZStack {
            Spacer()
            VStack(spacing: 50) {
                
                //Title
                Text("Neumorphic SwiftUI").font(.title2).fontWeight(.bold).foregroundColor(.black)
                
                SSNuemorphicView().frame(width: 150, height: 150)
                
                HStack {
                    SSNuemorphicTextField(placeholder: "Password")
                }
                
                SSNuemorphicButton(text: "Nuemorphic Button", pressedEffect: .flat) {
                    print("Clicked")
                }
                
                //Circle Button
                Button(action: {}) {
                    Image(systemName: "heart.fill")
                }.buttonStyle(Circle())
                
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
