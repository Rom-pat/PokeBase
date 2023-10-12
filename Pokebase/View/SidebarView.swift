//
//  SidebarView.swift
//  Pokebase
//
//  Created by romit patel on 9/14/23.
//

import SwiftUI

struct SidebarView: View {
    @Binding var Chosen_Region: Regions?
    @Binding var Dex:  available_pokedex?
    @State private var hovered: String?
    var game_dexs: [available_pokedex] = FullGameList.sorted(by: {$0.Gen < $1.Gen})
    var body: some View {
        VStack {
            Section("Discovered Region") {
                List(Regions.allCases, selection: $Chosen_Region) { key in
                    Button(key.rawValue){
                        Chosen_Region = key
                        Dex = nil
                    }.font(.largeTitle)
                        .onHover{_ in
                            hovered = key.rawValue
                        }
                        .foregroundStyle(Chosen_Region == key ? CustomColor.sidebarcolors : .accentColor)
                        .cornerRadius(/*@START_MENU_TOKEN@*/35.0/*@END_MENU_TOKEN@*/)
                }.padding(.top, -10.0).listStyle(.insetGrouped)
            }
            Section("Game Dexs") {
                List{
                    ForEach(game_dexs) { game_dex in
                        Button(game_dex.Name) {
                            Chosen_Region = nil
                            Dex = game_dex
                        }.font(.largeTitle)    .onHover{_ in
                            hovered = game_dex.Name
                        }
                        .foregroundStyle(Dex?.Name == game_dex.Name ? CustomColor.sidebarcolors : .accentColor)
                    }
                }.listStyle(.insetGrouped)
            }
        }.navigationTitle("Pokedex Sidebar")
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(Chosen_Region: .constant(.All), Dex: .constant(nil))
    }
}


