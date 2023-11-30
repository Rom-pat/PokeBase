//
//  MethodVieModel.swift
//  Pokebase
//
//  Created by romit patel on 11/18/23.
//

import Foundation
import SwiftUI
extension MethodView {
    @MainActor class MethodViewModel: ObservableObject {
        @Published var ChainFishingChance = 0.0
        @Published var FourRadar = 0.0
        @Published var SOSChain = 0.0
        @Published var CatchChain = 0.0
        var Gen4PokeRadar = [8, 9, 9, 9, 9, 10, 10,10, 10, 11, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 17, 18, 19, 20, 21, 22, 24, 26, 28, 30, 33, 37, 41, 47, 55, 66, 82, 110, 164, 328]
        var Gen8PokeRadar = [  "1/4,096", "1/3,855", "1/3,640", "1/3,449", "1/3,277", "1/3,121", "1/2,979", "1/2,849", "1/2,731", "1/2,621",
            "1/2,521", "1/2,427", "1/2,341", "1/2,259", "1/2,185",  "1/2,114", "1/2,048", "1/1,986", "1/1,927", "1/1,872",
            "1/1,820", "1/1,771", "1/1,724", "1/1,680", "1/1,638", "1/1,598","1/1,560", "1/1,524",  "1/1,489", "1/1,456",
            "1/1,310", "1/1,285", "1/1,260", "1/1,236", "1/1,213", "1/1,192", "1/993","1/799", "1/400", "1/200", "1/99",
        ]
        func FishChance(ShinyCharm: Bool) -> Int {
            var FishVal = 2*self.ChainFishingChance+1
            if ShinyCharm {
                FishVal += 2
            }
            return Int(round(4096/FishVal))
        }
        func Gen4Radar() -> Int {
            return 65536/Gen4PokeRadar[Int(FourRadar)]
        }
        func Gen8Radar() -> String {
            return Gen8PokeRadar[Int(FourRadar)]
        }
        func MasudaMethod(rate : Int, ShinyCharm: Bool, Reroll: Int) -> Int {
            if ShinyCharm {
                return rate / (Reroll + 2 + 1)
            }
            return rate / (Reroll + 1)
        }
        func SOS(ShinyCharm: Bool) -> String {
            var odds = ShinyCharm ? 3 : 1
            if SOSChain < 11 {
                odds += 0
            }
            else if SOSChain < 21 {
                odds += 4
            }
            else if SOSChain < 31 {
                odds += 8
            }
            else {
                odds += 12
            }
            return "1/\(4096/odds)"
        }
        func CatchCombo(ShinyCharm: Bool, Lure: Bool) -> String {
            var odds = ShinyCharm ? 3 : 1
            odds += (Lure) ? 1 : 0
            if CatchChain < 11 {
                odds += 0
            }
            else if CatchChain < 21 {
                odds += 3
            }
            else if CatchChain < 31 {
                odds += 7
            }
            else {
                odds += 11
            }
            return "1/\(4096/odds)"
        }
    }
}





