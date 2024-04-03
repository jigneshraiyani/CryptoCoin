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

struct ColorTheme2 {
    let accentColor = Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
    let backgroundColor = Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
    let greenColor = Color(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))
    let redColor = Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
    let secondaryTextColor = Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
}

struct LaunchTheme {
    let accent = Color(Constant.LaunchColor.launchAccentColor)
    let background = Color(Constant.LaunchColor.launchBackgroundColor)
}
