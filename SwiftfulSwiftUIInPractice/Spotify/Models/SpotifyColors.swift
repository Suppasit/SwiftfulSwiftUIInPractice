//
//  SpotifyColors.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 24/7/2567 BE.
//

import Foundation
import SwiftUI

struct SpotifyColors {
    static let black: Color = Color(hex: 0x121212)
    static let darkGray: Color = Color(hex: 0x212121)
    static let gray: Color = Color(hex: 0x535353)
    static let green: Color = Color(hex: 0x57B65F)
    static let lightGray: Color = Color(hex: 0xB3B3B3)
    static let white: Color = Color(hex: 0xE1E2E2)
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
