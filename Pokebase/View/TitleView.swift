//
//  TItleView.swift
//  Pokebase
//
//  Created by romit patel on 10/6/23.
//

import SwiftUI

struct TitleView: View {
    @Binding var Pokedex : [Pokemon_data]
    @Binding var shiny_count : Int
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        Text(String(count_mons(Pokedex: Pokedex)) + "/" + String(Pokedex.count) + " Shinies")
        .foregroundColor(color)
        .font(.largeTitle)
        
    }
}

private extension TitleView {
    var color :Color {
        if count_mons(Pokedex: Pokedex) == Pokedex.count {
            return .green
        }
        else {
            
            return (colorScheme == .dark ? .white : .black)
        }
    }
}
#Preview {TitleView(Pokedex: .constant(Pokemon_data.Examples().filter( {
        pokemon in pokemon.Region == Regions.Kanto.rawValue
    })),shiny_count: .constant(0))
}
