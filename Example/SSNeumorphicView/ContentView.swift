//
//  ContentView.swift
//  SSNeumorphicView
//
//  Created by Parth Dumaswala on 10/10/22.
//

import SwiftUI
import SSNeumorphicSwiftUIKit

struct ContentView: View {
    
    @State private var strPassword: String = ""
    
    var body: some View {
        return ZStack {
            
            VStack(spacing: 20) {
                
                //Title
                Text("Neumorphic SwiftUI").font(.title2).fontWeight(.bold).foregroundColor(.black)
                
                SSNuemorphicView().frame(width: 150, height: 150)
                
                HStack {
                    SSNuemorphicTextField(placeholder: "Enter Name", hasTrailingImage: true, imageName: "person")
                }
                
                HStack {
                    SSNuemorphicTextField(placeholder: "Enter Password", isSecureField: true, hasTrailingImage: true, imageName: "eye")
                }
                
                SSNuemorphicButton(text: "Nuemorphic Button", pressedEffect: .flat) {
                    print("Clicked")
                }
                
                //Circle Button with button stype
                Button(action: {}) {
                    Image(systemName: "heart.fill")
                }.buttonStyle(Circle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
