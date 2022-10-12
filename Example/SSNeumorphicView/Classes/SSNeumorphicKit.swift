//
//  SSNeumorphic.swift
//
//  Created by Parth Dumaswala on 10/10/22.
//

import SwiftUI

public struct SSNeumorphicKit {
    
    public enum ColorSchemeType {
        case auto, light, dark
    }
    
    public static var colorSchemeType : ColorSchemeType = .auto
    
#if os(macOS)
    public typealias ColorType = NSColor
    public static func colorType(red: CGFloat, green: CGFloat, blue: CGFloat) -> ColorType {
        .init(red: red, green: green, blue: blue, alpha: 1.0)
    }
#else
    public typealias ColorType = UIColor
    public static func colorType(red: CGFloat, green: CGFloat, blue: CGFloat) -> ColorType {
        .init(red: red, green: green, blue: blue, alpha: 1.0)
    }
#endif
    
    public static func color(light: ColorType, dark: ColorType) -> Color {
#if os(iOS)
        switch SSNeumorphicKit.colorSchemeType {
            case .light:
                return Color(light)
            case .dark:
                return Color(dark)
            case .auto:
                return Color(.init { $0.userInterfaceStyle == .light ? light : dark })
        }
#else
        switch SSNeumorphicKit.colorSchemeType {
            case .light:
                return Color(light)
            case .dark:
                return Color(dark)
            case .auto:
                return Color(.init(name: nil, dynamicProvider: { (appearance) -> NSColor in
                    return appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? dark : light
                }))
        }
#endif
    }
    
}

struct SSNuemorphicView: View {
    
    var fillColor: Color = .white
    var cornerRadius : CGFloat = 15
    
    var body: some View {
        
        //Rectangle
        RoundedRectangle(cornerRadius: cornerRadius).fill(fillColor)
        
            .outerShadow()
            .innerShadow(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct SSNuemorphicTextField: View {

    var placeholder: String
    @State var textFieldContent: String = ""

    var body: some View {
        
        HStack {
            TextField(placeholder, text: $textFieldContent).padding()
            Image(systemName:"eye.slash")
                .foregroundColor(.black)
             .font(Font.body.weight(.bold))
        }.background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .outerShadow()
                .innerShadow(RoundedRectangle(cornerRadius: 30))
        ).padding()
    }
}

struct SSNuemorphicButton: View {
    
    var text: String = ""
    var pressedEffect:ButtonPressedEffect = .none
    var action: () -> Void

    var body: some View {
    
        //Button
        Button(action: action) {
            Text(text).foregroundColor(.black)
                .fontWeight(.bold).frame(width: 300, height: 20)
        }
        .buttonStyle(Capsule(), padding: 15, pressedEffect: pressedEffect)
    }
}
