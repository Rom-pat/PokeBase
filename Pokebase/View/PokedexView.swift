//
//  PokedexRegionView.swift
//  Pokebase
//
//  Created by romit patel on 9/14/23.
//

import SwiftUI

struct PokedexRegionView: View {
    @Binding var Pokedex : [Pokemon_data]
    @StateObject var PokedexRegionVM =
    PokedexViewModel()
    let Region: String
    let Region_Gradient: LinearGradient
    @Environment(\.isSearching) private var isSearching
    var body: some View {
        VStack {
            TitleView(Pokedex: $Pokedex,shiny_count: $PokedexRegionVM.shiny_count)
            NavigationStack{
                ZStack {
                    Region_Gradient.ignoresSafeArea()
                    List {
                        ForEach(searchResults) { pokemon in
                            navigateView(pokemon: pokemon,shiny_count: $PokedexRegionVM.shiny_count)
                        }
                    }
                    .searchable(text: $PokedexRegionVM.searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Which Pokemon") {
                    }
                }.scrollContentBackground( .hidden)
                    .padding()
            }
            .navigationTitle(TitleText)
            .alert("Shiny Swapper",
                   isPresented: $PokedexRegionVM.Popup,actions: {
                PopupView(Pokedex: $Pokedex, shiny_count: $PokedexRegionVM.shiny_count)
            },message: {Text("please enter range of Pokemon to mass turn on/off as shiny")}
            )
        }.toolbar(content: {
            Dex_toolbar()
        })
    }
}

struct navigateView: View {
    @ObservedObject var pokemon: Pokemon_data
    @Binding var shiny_count: Int
    var body: some View {
        NavigationLink(destination: {PokemonView(thispokemon: pokemon, shiny_count: $shiny_count, PokemonVM: PokemonView.PokemonViewModel()
        )}) {
            HStack {
                Text("#"+String(pokemon.id) + " "  + pokemon.PokemonName)
                    .font(.headline)
                    .foregroundStyle(pokemon.display_toggle ? Color.green : Color.accentColor)
                Spacer()
                Image(pokemon.display_toggle ? pokemon.Shiny_image : pokemon.Poke_image)
            }
        }
    }
}

struct PokedexRegionView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexRegionView(
            Pokedex: .constant(Pokemon_data.Examples().filter( {
                pokemon in pokemon.Region == Regions.Kanto.rawValue
            })), PokedexRegionVM: PokedexRegionView.PokedexViewModel(),Region: Regions.Kanto.rawValue, Region_Gradient: LinearGradient(gradient: Gradient(colors: RegionList[.Kanto]!.colorset), startPoint: .leading, endPoint: .trailing)
        )
    }
}
