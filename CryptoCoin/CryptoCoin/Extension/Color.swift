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
    
    struct LaunchColor {
        static let launchAccentColor = "LaunchAccentColor"
        static let launchBackgroundColor = "LaunchBackgroundColor"
    }
}

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accentColor = Color(Constant.Color.accentColor)
    let backgroundColor = Color(Constant.Color.backgroundColor)
    let greenColor = Color(Constant.Color.greenColor)
    let redColor = Color(Constant.Color.redColor)
    let secondaryTextColor = Color(Constant.Color.secondaryTextColor)
}

struct LaunchTheme {
    let accent = Color(Constant.LaunchColor.launchAccentColor)
    let background = Color(Constant.LaunchColor.launchBackgroundColor)
}
