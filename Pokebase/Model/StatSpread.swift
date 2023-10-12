//
//  BarData.swift
//  Pokebase
//
//  Created by romit patel on 9/21/23.
//

import Foundation

struct StatSpread: Identifiable, Codable {
    var value : Int
    var Stat: String
    var color: String
    var id  = UUID()
}


func return_spread(dataum: Array<String>) -> [StatSpread] {
    return [
        .init(value: Int(dataum[5]) ?? 0, Stat: "HP", color: "Yellow"),
        .init(value: Int(dataum[6]) ?? 0, Stat: "Attack", color: "Red"),
        .init(value: Int(dataum[7]) ?? 0, Stat: "Defense", color: "Green"),
        .init(value:  Int(dataum[8]) ?? 0, Stat: "Special Attack", color: "Purple"),
        .init(value: Int(dataum[9]) ?? 0, Stat: "Special Defense", color: "Orange"),
        .init(value: Int(dataum[10]) ?? 0, Stat: "Speed", color: "Blue"),
    ]
}
