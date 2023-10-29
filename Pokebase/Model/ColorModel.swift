//
//  ColorModel.swift
//  Pokebase
//
//  Created by romit patel on 9/26/23.
//

import Foundation
import SwiftUI

struct CustomColor {
    static let sidebarcolors  = Color("SideColor")
    static let Top_col = Color(.sRGB, red: 100/255, green: 255/255, blue: 255/255)
    static let bottom_col = Color(.sRGB, red: 7/255, green: 134/255, blue: 134/255)
}

struct Region_info {
    var RegionDex : Set<Int>
    var colorset : [Color]
}
let RegionList: [Regions:Region_info] = [
    .All : .init(RegionDex: [0], colorset: [CustomColor.Top_col,CustomColor.bottom_col]),
    .Kanto: .init( RegionDex:  Set(1...151),
                       colorset:[Color(hex: 0xff1111),Color(hex: 0xffd733),Color(hex: 0x1111ff)]),
    .Johto: .init(RegionDex:  Set(152...251), colorset: [Color(hex: 0xdaa520),Color(hex: 0x4fd9ff),Color(hex: 0xc0c0c0)]),
    .Hoenn: .init(RegionDex:  Set(252...386), colorset:[Color(hex: 0xa00000),Color(hex: 0x00a000),Color(hex: 0x0000a0)]),
    .Sinnoh: .init( RegionDex: Set(387...493), colorset: [Color(hex: 0xaaaaff),Color(hex: 0x999999),Color(hex: 0xffaaaa)]),
    .Unova : .init(RegionDex:  Set(494...649), colorset: [Color(hex: 0x444444),Color(hex: 0xe1e1e1)]),
    .Kalos: .init( RegionDex:  Set(650...721), colorset:[Color(hex: 0xed5540),Color(hex: 0x6376b8)]),
    .Alola: .init(RegionDex:  Set(722...807), colorset: [Color(hex: 0x5599ca),Color(hex: 0xf1912b)]),
    .Galar: .init(RegionDex:  Set(810...898), colorset: [Color(hex: 0x9e2306),Color(hex: 0x00d1f6)]),
    .Hisui: .init(RegionDex:  Set(899...905), colorset: [Color(hex: 0xdaa520),Color(hex: 0xc0c0c0)]),
    .Paldea: .init(RegionDex:  Set(906...1017), colorset:[Color(hex: 0xc91421),Color(hex: 0x632ea6)]),
    .Unkown: .init(RegionDex: [808,809], colorset:[Color(hex: 0x808080)]),
]

let Type_colors : [String:Color]  = [
    "Normal": Color(.sRGB, red: 159/255, green: 161/255, blue: 158/255),
    "Fire" : Color(.sRGB, red: 230/255, green: 40/255, blue: 40/255),
    "Water" : Color(.sRGB, red: 42/255, green: 129/255, blue: 239/255),
    "Electric" : Color(.sRGB, red: 250/255, green: 191/255, blue: 0/255),
    "Grass" : Color(.sRGB, red: 63/255, green: 161/255, blue: 42/255),
    "Ice" : Color(.sRGB, red: 63/255, green: 217/255, blue: 158/255),
    "Fighting" : Color(.sRGB, red: 255/255, green: 127/255, blue: 0/255),
    "Poison" : Color(.sRGB, red: 146/255, green: 65/255, blue: 204/255),
    "Ground" : Color(.sRGB, red: 145/255, green: 81/255, blue: 33/255),
    "Flying" : Color(.sRGB, red: 129/255, green: 184/255, blue: 238/255),
    "Psychic" : Color(.sRGB, red: 238/255, green: 65/255, blue: 121/255),
    "Bug" : Color(.sRGB, red: 145/255, green: 161/255, blue: 26/255),
    "Rock" : Color(.sRGB, red: 174/255, green: 169/255, blue: 129/255),
    "Ghost" : Color(.sRGB, red: 112/255, green: 64/255, blue: 112/255),
    "Dragon" : Color(.sRGB, red: 81/255, green: 96/255, blue: 225/255),
    "Dark" : Color(.sRGB, red: 80/255, green: 65/255, blue: 62/255),
    "Steel" : Color(.sRGB, red: 96/255, green: 161/255, blue: 183/255),
    "Fairy" : Color(.sRGB, red: 238/255, green: 112/255, blue: 238/255),
    
    /*
     gen 6 type colors. above used is gen 9
     "Normal": Color(hex: 0xA8A77A),
     "Fire" : Color(hex: 0xEE8130),
     "Water" : Color(hex: 0x6390F0),
     "Electric" : Color(hex: 0xF7D02C),
     "Grass" : Color(hex: 0x7AC74C),
     "Ice" : Color(hex: 0x96D9D6),
     "Fighting" : Color(hex: 0xC22E28),
     "Poison" : Color(hex: 0xA33EA1),
     "Ground" : Color(hex: 0xE2BF65),
     "Flying" : Color(hex: 0xA98FF3),
     "Psychic" : Color(hex: 0xF95587),
     "Bug" : Color(hex: 0xA6B91A),
     "Rock" : Color(hex: 0xB6A136),
     "Ghost" : Color(hex: 0x735797),
     "Dragon" : Color(hex: 0x6F35FC),
     "Dark" : Color(hex: 0x705746),
     "Steel" : Color(hex: 0xB7B7CE),
     "Fairy" : Color(hex: 0xD685AD)
     */
]
