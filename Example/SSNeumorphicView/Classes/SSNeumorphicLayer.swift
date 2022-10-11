//
//  SSNeumorphicLayer.swift
//  SSNeumorphicView
//
//  Created by Parth Dumaswala on 11/10/22.
//

import SwiftUI
import Foundation

extension View {
    
    func inverseMask<Mask>(_ mask: Mask) -> some View where Mask: View {
        self.mask(mask
            .foregroundColor(.black)
            .background(Color.white)
            .compositingGroup()
            .luminanceToAlpha()
        )
    }
    
    public func outerShadow(darkShadow: Color = Color.Neumorphic.darkShadow, lightShadow: Color = Color.Neumorphic.lightShadow, offset: CGFloat = 6, radius:CGFloat = 3) -> some View {
        modifier(OuterShadowViewModifier(darkShadowColor: darkShadow, lightShadowColor: lightShadow, offset: offset, radius: radius))
    }
    
    public func innerShadow<S : Shape>(_ content: S, darkShadow: Color = Color.Neumorphic.darkShadow, lightShadow: Color = Color.Neumorphic.lightShadow, spread: CGFloat = 0.5, radius: CGFloat = 10) -> some View {
        modifier(
            InnerShadowViewModifier(shape: content, darkShadowColor: darkShadow, lightShadowColor: lightShadow, spread: spread, radius: radius)
        )
    }
}

public extension Color {
    
    struct Neumorphic {
        //Color
        private static let defaultMainColor = SSNeumorphicKit.colorType(red: 0.925, green: 0.941, blue: 0.953)
        private static let defaultSecondaryColor = SSNeumorphicKit.colorType(red: 0.482, green: 0.502, blue: 0.549)
        private static let defaultLightShadowSolidColor = SSNeumorphicKit.colorType(red: 1.000, green: 1.000, blue: 1.000)
        private static let defaultDarkShadowSolidColor = SSNeumorphicKit.colorType(red: 0.820, green: 0.851, blue: 0.902)
        
        private static let darkThemeMainColor = SSNeumorphicKit.colorType(red: 0.188, green: 0.192, blue: 0.208)
        private static let darkThemeSecondaryColor = SSNeumorphicKit.colorType(red: 0.910, green: 0.910, blue: 0.910)
        private static let darkThemeLightShadowSolidColor = SSNeumorphicKit.colorType(red: 0.243, green: 0.247, blue: 0.275)
        private static let darkThemeDarkShadowSolidColor = SSNeumorphicKit.colorType(red: 0.137, green: 0.137, blue: 0.137)
        
        public static var colorSchemeType : SSNeumorphicKit.ColorSchemeType {
            get {
                return SSNeumorphicKit.colorSchemeType
            }
            set {
                SSNeumorphicKit.colorSchemeType = newValue
            }
        }
        
        public static var main: Color {
            SSNeumorphicKit.color(light: defaultMainColor, dark: darkThemeMainColor)
        }
        
        public static var secondary: Color {
            SSNeumorphicKit.color(light: defaultSecondaryColor, dark: darkThemeSecondaryColor)
        }
        
        public static var lightShadow: Color {
            SSNeumorphicKit.color(light: defaultLightShadowSolidColor, dark: darkThemeLightShadowSolidColor)
        }
        
        public static var darkShadow: Color {
            SSNeumorphicKit.color(light: defaultDarkShadowSolidColor, dark: darkThemeDarkShadowSolidColor)
        }
    }
}

private struct OuterShadowViewModifier: ViewModifier {
    var lightShadowColor : Color
    var darkShadowColor : Color
    var offset: CGFloat
    var radius : CGFloat
    
    init(darkShadowColor: Color, lightShadowColor: Color, offset: CGFloat, radius: CGFloat) {
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.offset = offset
        self.radius = radius
    }

    func body(content: Content) -> some View {
        content
        .shadow(color: darkShadowColor, radius: radius, x: offset, y: offset)
        .shadow(color: lightShadowColor, radius: radius, x: -offset, y: -offset)
    }
}

private struct InnerShadowViewModifier<S: Shape> : ViewModifier {
    var shape: S
    var darkShadowColor : Color = .black
    var lightShadowColor : Color = .white
    var spread: CGFloat = 0.5    //The value of spread is between 0 to 1. Higher value makes the shadow look more intense.
    var radius: CGFloat = 10
    
    init(shape: S, darkShadowColor: Color, lightShadowColor: Color, spread: CGFloat, radius:CGFloat) {
        self.shape = shape
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.spread = spread
        self.radius = radius
    }

    fileprivate func strokeLineWidth(_ geo: GeometryProxy) -> CGFloat {
        return geo.size.width * 0.10
    }
    
    fileprivate func strokeLineScale(_ geo: GeometryProxy) -> CGFloat {
        let lineWidth = strokeLineWidth(geo)
        return geo.size.width / CGFloat(geo.size.width - lineWidth)
    }
    
    fileprivate func shadowOffset(_ geo: GeometryProxy) -> CGFloat {
        return (geo.size.width <= geo.size.height ? geo.size.width : geo.size.height) * 0.5 * min(max(spread, 0), 1)
    }
    

    fileprivate func addInnerShadow(_ content: InnerShadowViewModifier.Content) -> some View {
        return GeometryReader { geo in
            
            self.shape.fill(self.lightShadowColor)
                .inverseMask(
                    self.shape
                    .offset(x: -self.shadowOffset(geo), y: -self.shadowOffset(geo))
                )
                .offset(x: self.shadowOffset(geo) , y: self.shadowOffset(geo))
                .blur(radius: self.radius)
                .shadow(color: self.lightShadowColor, radius: self.radius, x: -self.shadowOffset(geo)/2, y: -self.shadowOffset(geo)/2 )
                .mask(
                    self.shape
                )
                .overlay(
                    self.shape
                        .fill(self.darkShadowColor)
                        .inverseMask(
                            self.shape
                            .offset(x: self.shadowOffset(geo), y: self.shadowOffset(geo))
                        )
                        .offset(x: -self.shadowOffset(geo) , y: -self.shadowOffset(geo))
                        .blur(radius: self.radius)
                        .shadow(color: self.darkShadowColor, radius: self.radius, x: self.shadowOffset(geo)/2, y: self.shadowOffset(geo)/2 )
                )
                .mask(
                    self.shape
                )
        }
    }

    func body(content: Content) -> some View {
        content.overlay(
            addInnerShadow(content)
        )
    }
}
