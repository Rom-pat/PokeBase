//
//  ContentView.swift
//  Pokebase
//
//  Created by romit patel on 9/10/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var Pokedex: [Pokemon_data]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    @State private var choosen_region: Regions?
    @State private var choosen_game_Dex: available_pokedex?
    var body: some View {
        NavigationSplitView{
            SidebarView(Chosen_Region: $choosen_region, Dex: $choosen_game_Dex)
        } detail: {
            if choosen_region != nil {
                PokedexRegionView(Pokedex: ReturnRegionFunc(location: choosen_region!, Pokedex: Pokedex),Region: choosen_region!.rawValue
                                    ,Region_Gradient: LinearGradient(gradient: Gradient(colors: RegionList[choosen_region ?? .All]!.colorset), startPoint: .leading, endPoint: .trailing))
            }
            else if choosen_game_Dex != nil{
                PokedexRegionView(Pokedex: ReturnGameDex(Pokedex: Pokedex, gameDex: Set(choosen_game_Dex!.Dex)), Region: choosen_game_Dex!.Name, Region_Gradient:  LinearGradient(gradient: Gradient(colors: RegionList[ .All]!.colorset), startPoint: .leading, endPoint: .trailing))
            }
            else  {
                PokedexRegionView(Pokedex:
            ReturnRegionFunc(location:.All, Pokedex: Pokedex)
                                  ,Region: "All", Region_Gradient:  LinearGradient(gradient: Gradient(colors: RegionList[ .All]!.colorset), startPoint: .leading, endPoint: .trailing))
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(Pokedex: .constant(getCSVdata()), saveAction: {})
    }
}
