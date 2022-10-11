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
        
        let cornerRadius : CGFloat = 15
        let mainColor = Color.white//Neumorphic.main
    
        return ZStack {
            Spacer()
            VStack(spacing: 50) {
                //Title
                Text("Neumorphic SwiftUI").font(.title2).fontWeight(.bold).foregroundColor(.black)
                
                //Rectangle
                RoundedRectangle(cornerRadius: cornerRadius).fill(mainColor).frame(width: 150, height: 150)
                
                    .outerShadow()
                    .innerShadow(RoundedRectangle(cornerRadius: cornerRadius))
                
                //TextField
                HStack {
                    SecureField("Password", text: $strPassword)
                        .foregroundColor(.black)
                        .textContentType(.password)
                    
                    Image(systemName:"eye.slash")
                        .foregroundColor(.black)
                     .font(Font.body.weight(.bold))
                  }
                  .padding()
                  .background(
                     RoundedRectangle(cornerRadius: 30)
                      .fill(mainColor)
                        //.outerShadow()
                        .innerShadow(RoundedRectangle(cornerRadius: 30), spread: 0.05, radius: 2)
                  ).padding()
                
                //Button
                Button(action: {}) {
                    Text("Neumorphic Button").foregroundColor(.black)
                        .fontWeight(.bold)
                        .frame(width: 290, height: 20)
                }
                .buttonStyle(Capsule(), padding: 15, pressedEffect: .flat)
                
                
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
