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

public struct SSNuemorphicView: View {
    
    public init(fillColor: Color = .white, cornerRadius: CGFloat = 15) {
        self.fillColor = fillColor
        self.cornerRadius = cornerRadius
    }
    
    var fillColor: Color = .white
    var cornerRadius : CGFloat = 15
    
    public var body: some View {
        
        //Rectangle
        RoundedRectangle(cornerRadius: cornerRadius).fill(fillColor)
        
            .outerShadow()
            .innerShadow(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

public struct SSNuemorphicTextField: View {
    
    public init(placeholder: String, isSecureField: Bool = false, hasTrailingImage: Bool = false, imageName: String = "", textFieldContent: String = "") {
        self.placeholder = placeholder
        self.isSecureField = isSecureField
        self.hasTrailingImage = hasTrailingImage
        self.imageName = imageName
        self.textFieldContent = textFieldContent
    }
    
    var placeholder: String
    var isSecureField = false
    var hasTrailingImage = false
    var imageName: String = ""
    @State var textFieldContent: String = ""

    public var body: some View {
        
        HStack {
            
            if isSecureField {
                SecureField(placeholder, text: $textFieldContent).padding()
                    .font(Font.body.weight(.bold))
            } else {
                TextField(placeholder, text: $textFieldContent).padding()
                    .font(Font.body.weight(.bold))
            }
            
            if hasTrailingImage {
                Image(systemName: imageName)
                    .foregroundColor(.black)
            }
            
        }.padding(.trailing)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .innerShadow(RoundedRectangle(cornerRadius: 30))
                    .outerShadow()
            ).padding()
    }
}

public struct SSNuemorphicButton: View {
    
    public init(text: String = "", pressedEffect: ButtonPressedEffect = .none, action: @escaping () -> Void) {
        self.text = text
        self.pressedEffect = pressedEffect
        self.action = action
    }

    var text: String = ""
    var pressedEffect:ButtonPressedEffect = .none
    var action: () -> Void

    public var body: some View {
    
        //Button
        Button(action: action) {
            Text(text).foregroundColor(.black)
                .fontWeight(.bold).frame(width: 300, height: 20)
        }
        .buttonStyle(Capsule(), padding: 15, pressedEffect: pressedEffect)
    }
}
