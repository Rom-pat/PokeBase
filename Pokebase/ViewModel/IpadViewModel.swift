//
//  ContentViewModel.swift
//  Pokebase
//
//  Created by romit patel on 10/23/23.
//

import Foundation
import SwiftUI
extension IpadView {
    @MainActor class IpadViewModel: ObservableObject {
        @Published var choosen_region: Regions?
        @Published var choosen_game_Dex: available_pokedex?
        @Published var Selected: String?
        var All_names: [String]  = Regions.allCases.map({$0.rawValue})  + available_pokedex.set_game_list().map({$0.Name})
        init(choosen_region: Regions? = .All, choosen_game_Dex: available_pokedex? = nil) {
            self.choosen_region = choosen_region
            self.choosen_game_Dex = choosen_game_Dex
        }
        
        func determine_Dex(Pokedex: [Pokemon_data]) -> (Pokedex: Binding<[Pokemon_data]>, Region: String,Region_Gradient : LinearGradient)  {
            if  choosen_region != nil {
                return (ReturnRegionFunc(location: choosen_region!, Pokedex: Pokedex), choosen_region!.rawValue,determine_gradient())
            }
            else if choosen_game_Dex != nil{
                return (ReturnGameDex(Pokedex: Pokedex, gameDex: Set(choosen_game_Dex!.Dex)),choosen_game_Dex!.Name, determine_gradient())
            }
            return(ReturnRegionFunc(location:.All, Pokedex: Pokedex), "All", determine_gradient())
        }
        
        func set_dex(Reg: Regions?, GDex: available_pokedex?) {
            choosen_region = Reg
            choosen_game_Dex = GDex
        }
        
        private func determine_gradient() -> LinearGradient {
            return LinearGradient(gradient: Gradient(colors: RegionList[choosen_region ?? .All]!.colorset), startPoint: .leading, endPoint: .trailing)
        }
    }
}
