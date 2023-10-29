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
    @State private var Selected: String? = "All"
    var game_dexs: [available_pokedex] = FullGameList.sorted(by: {$0.Gen < $1.Gen})
    var body: some View {
        List(selection: $Selected, content: {
            
            Section(content: {
                ForEach(Regions.allCases) { key in
                    Button(key.rawValue){
                        Chosen_Region = key
                        Dex = nil
                    }.font(.title)
                        .onHover{_ in
                            hovered = key.rawValue
                        }
                        .foregroundStyle(Chosen_Region == key ? CustomColor.sidebarcolors : .accentColor)
                        .cornerRadius(/*@START_MENU_TOKEN@*/35.0/*@END_MENU_TOKEN@*/)
                        .padding()
                }
            },header: { Text("Regions").foregroundStyle(Color.accentColor).font(.largeTitle).textCase(nil) })
            Section(content: {
                ForEach(game_dexs) { game_dex in
                    Button(game_dex.Name) {
                        Chosen_Region = nil
                        Dex = game_dex
                    }.font(.title)
                        .onHover{_ in
                        hovered = game_dex.Name
                    }
                    .foregroundStyle(Dex == game_dex ? CustomColor.sidebarcolors : .accentColor)
                    .padding()
                }
            },header: {
                Text("Game Dex").foregroundStyle(Color.accentColor).font(.largeTitle).textCase(nil)
            })
        }).navigationTitle("Pokedex Sidebar").listStyle(.insetGrouped)
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(Chosen_Region: .constant(.All), Dex: .constant(nil))
    }
}


