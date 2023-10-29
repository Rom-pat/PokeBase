//
//  IpadView.swift
//  Pokebase
//
//  Created by romit patel on 10/19/23.
//

import SwiftUI

struct IpadView: View {
    @Binding var Pokedex: [Pokemon_data]
    @StateObject private var ViewModel = IpadViewModel()
    var body: some View {
        NavigationSplitView{
            SidebarView(Chosen_Region: $ViewModel.choosen_region, Dex: $ViewModel.choosen_game_Dex)
        } detail: {
            let PokedexArgs = ViewModel.determine_Dex(Pokedex: Pokedex)
            TabView {
                PokedexRegionView(Pokedex: PokedexArgs.Pokedex, PokedexRegionVM: PokedexRegionView.PokedexViewModel(),Region: PokedexArgs.Region, Region_Gradient: PokedexArgs.Region_Gradient)
                .tabItem {Label("Dex", systemImage: "list.dash") }
            }
        }
    }
}

#Preview {
    IpadView(Pokedex: .constant(Pokemon_data.Examples()))
}
