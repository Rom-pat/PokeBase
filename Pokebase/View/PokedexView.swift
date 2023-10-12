//
//  PokedexRegionView.swift
//  Pokebase
//
//  Created by romit patel on 9/14/23.
//

import SwiftUI

struct PokedexRegionView: View {
    @State private var shiny_count : Int = 0
    @Binding var Pokedex : [Pokemon_data]
    let Region: String
    @State private var searchText: String = ""
    @State private var Popup: Bool = false
    let Region_Gradient : LinearGradient
    let typings = ["All Types"] + Type_colors.keys
    @State private var type_selection = "All Types"
    @State private var shiny_selection = Form.All
    var body: some View {
        VStack {
            TitleView(Pokedex: $Pokedex,shiny_count: $shiny_count)
            NavigationStack{
                ZStack {
                    Region_Gradient.ignoresSafeArea()
                    List {
                        ForEach(searchResults) { pokemon in
                            navigateView(pokemon: pokemon,shiny_count: $shiny_count)
                        }
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Which Pokemon") {
                        ForEach(searchResults){
                            result in
                            navigateView(pokemon: result,shiny_count: $shiny_count)
                            /*Text(result.PokemonName).fontWeight(.bold)*/.searchCompletion(result.PokemonName)
                        }
                    }
                }.scrollContentBackground(.hidden)
                    .toolbar(content: {
                    ToolbarItemGroup(placement:.bottomBar, content: {
                        Button(action: {
                            Popup = true
                        }, label: {Label(title: {Text("Shiny")}, icon: {
                            Image("ShinyLabel").resizable().scaledToFit() .padding(.horizontal, 30)
                                .frame(height: 44)
                        } )}
                        ).buttonStyle(.borderless).padding(.top)
                        Spacer()
                        Picker("Types", selection: $type_selection) {
                            ForEach(typings.sorted(), id: \.self) {
                                Text($0).font(.largeTitle)
                            }
                        }.scaleEffect(1.5)
                        Spacer()
                        Picker("All", selection: $shiny_selection) {
                            Text("All").tag(Form.All)
                            Text(" Shinies").tag(Form.Shinies)
                            Text("Regular").tag(Form.NonShinies)
                            
                        }.padding(.trailing, -5.0).scaleEffect(1.5).padding()
                        Spacer()
                    })
                })
            }.navigationTitle(Title_text)
            .alert("Shiny Swapper",
                   isPresented: $Popup,actions: {
                PopupView(Pokedex: $Pokedex, shiny_count: $shiny_count)
            },message: {Text("please enter range of Pokemon to mass turn on/off as shiny")}
            )
        }
    }
}
struct navigateView: View {
    @ObservedObject var pokemon: Pokemon_data
    @Binding var shiny_count: Int
    var body: some View {
        NavigationLink(destination: {PokemonView(thispokemon: pokemon, shiny_count: $shiny_count
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
            Pokedex: .constant(getCSVdata().filter( {
                pokemon in pokemon.Region == Regions.Kanto.rawValue
            }))
            , Region: Regions.Kanto.rawValue, Region_Gradient:  LinearGradient(gradient: Gradient(colors: RegionList[.Kanto]!.colorset), startPoint: .leading, endPoint: .trailing)
        )
    }
}

private extension PokedexRegionView {
    var searchResults: [Pokemon_data] {
        var SearchDex : [Pokemon_data] = Pokedex
        if type_selection != "All Types" {
            SearchDex = SearchDex.filter{
                $0.Type1 == type_selection || $0.Type2 == type_selection
            }
        }
        if shiny_selection != Form.All {
            SearchDex = SearchDex.filter{
                $0.display_toggle == ((shiny_selection == Form.Shinies) ? true : false)
            }
        }
        if searchText.isEmpty {
            return SearchDex
        }
        else {
            return SearchDex.filter{ Poke in
                Poke.PokemonName.contains(searchText)
            }
        }
    }
    var Title_text : Text {
        var return_val: Text
        if Region == Regions.All.rawValue{
            return_val = Text("National Dex")
        }
        else {
            return_val =  Text(Region)
        }
        return return_val
    }
}

/*
 List(types.sorted(), id: \.self, selection: $poke_Type) { key in
     Button(key){
         poke_Type = key
         Chosen_Region = .All
     }.font(.largeTitle)
 }
 */
