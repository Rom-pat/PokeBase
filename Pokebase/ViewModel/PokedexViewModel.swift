//
//  PokedexViewModel.swift
//  Pokebase
//
//  Created by romit patel on 10/23/23.
//

import Foundation
import SwiftUI

extension PokedexRegionView {
    @MainActor class PokedexViewModel: ObservableObject {
        @Published var shiny_count : Int
        @Published var searchText: String
        @Published var Popup: Bool
        var typings = ["All Types"] + Type_colors.keys
        @Published var type_selection = "All Types"
        @Published var shiny_selection = Form.All
        init() {
            self.shiny_count = 0
            self.searchText = ""
            self.Popup = false
            self.typings = self.typings.sorted()
            self.type_selection = "All Types"
            self.shiny_selection = Form.All
        }
        func toggle_on() {
            self.Popup = true
        }
    }
    var TitleText: Text {
        var return_val: Text
        if Region == Regions.All.rawValue{
            return_val = Text("National Dex")
        }
        else {
            return_val =  Text(Region)
        }
        return return_val
    }
    var searchResults : [Pokemon_data] {
        var SearchDex : [Pokemon_data] = Pokedex
        if PokedexRegionVM.type_selection != "All Types" {
            SearchDex = SearchDex.filter{
                $0.Type1 == PokedexRegionVM.type_selection || $0.Type2 == PokedexRegionVM.type_selection
            }
        }
        if PokedexRegionVM.shiny_selection != Form.All {
            SearchDex = SearchDex.filter{
                $0.display_toggle == ((PokedexRegionVM.shiny_selection == Form.Shinies) ? true : false)
            }
        }
        if PokedexRegionVM.searchText.isEmpty {
            return SearchDex
        }
        else {
            return SearchDex.filter{ Poke in
                Poke.PokemonName.contains(PokedexRegionVM.searchText)
            }
        }
    }
    func DexToolbar() -> some ToolbarContent {
        ToolbarItemGroup(placement: ToolbarItemPlacement.bottomBar, content: {
        Button(action: {
            PokedexRegionVM.toggle_on()
        }, label: {Label(title: {Text("Shiny")}, icon: {
            Image("ShinyLabel").resizable().scaledToFit()
                .frame(height: 44)
        } )}
        ).buttonStyle(.borderless).padding(.top)
        Spacer()
        Picker("Types", selection: $PokedexRegionVM.type_selection) {
            ForEach(PokedexRegionVM.typings.sorted(), id: \.self) {
                Text($0).font(.largeTitle)
            }
        }.scaleEffect(1.5).tint(Color.blue)
        Spacer()
        Picker("All", selection: $PokedexRegionVM.shiny_selection) {
            Text("All").tag(Form.All)
            Text(" Shinies").tag(Form.Shinies)
            Text("Regular").tag(Form.NonShinies)
            
        }.padding(.trailing, -5.0).scaleEffect(1.5).tint(Color.blue)
        Spacer()
        })
    }
}

