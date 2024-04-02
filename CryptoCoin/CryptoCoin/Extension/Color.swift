//
//  Color.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/21/24.
//

import Foundation
import SwiftUI

struct Constant {
    struct Color {
        static let accentColor = "AccentColor"
        static let backgroundColor = "BackgroundColor"
        static let greenColor = "GreenColor"
        static let redColor = "RedColor"
        static let secondaryTextColor = "SecondaryTextColor"
    }
}

extension Color {
   static let theme = ColorTheme()
    
}

struct ColorTheme {
    let accentColor = Color(Constant.Color.accentColor)
    let backgroundColor = Color(Constant.Color.backgroundColor)
    let greenColor = Color(Constant.Color.greenColor)
    let redColor = Color(Constant.Color.redColor)
    let secondaryTextColor = Color(Constant.Color.secondaryTextColor)
}
