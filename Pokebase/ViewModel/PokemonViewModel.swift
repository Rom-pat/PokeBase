//
//  PokemonViewModel.swift
//  Pokebase
//
//  Created by romit patel on 10/24/23.
//

import Foundation
import SwiftUI
extension PokemonView {
    @MainActor class PokemonViewModel: ObservableObject {
        func DexNumber(Pokemon: Pokemon_data)-> String {
            return "#"+String(format: "%04d", Pokemon.id)
        }
        func LinkReturn(Pokemon: Pokemon_data) -> URL {
            return URL(string:                 "https://bulbapedia.bulbagarden.net/wiki/"+Pokemon.PokemonName.replacingOccurrences(of: " ", with: "_"))!
        }
    }
    var PokemonColors : LinearGradient {
        var color = [
            Type_colors[thispokemon.Type1]!
        ]
        if thispokemon.Type2 != "" {
            color.append(            Type_colors[thispokemon.Type2]!)
        }
        return LinearGradient(gradient: Gradient(colors: color), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    func toggle_off() {
        self.thispokemon.set_toggle()
        shiny_count += thispokemon.display_toggle ? 1  : -1
    }
    
}
