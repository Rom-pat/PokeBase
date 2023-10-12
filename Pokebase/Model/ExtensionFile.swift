//
//  ExtensionFile.swift
//  Pokebase
//
//  Created by romit patel on 10/1/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct SectionHeader: View {
    var Title: String
    var body: some View {
        Text(Title)
           .font(.title3)
           .bold()
           .foregroundStyle(Color.white)
           .textCase(nil)
    }
 }
