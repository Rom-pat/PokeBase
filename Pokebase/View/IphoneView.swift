//
//  IphoneView.swift
//  Pokebase
//
//  Created by romit patel on 10/19/23.
//

import SwiftUI

struct IphoneView: View {
    @Binding var Pokedex: [Pokemon_data]
    @EnvironmentObject var DexManager: DexViewManager
    var Games: [available_pokedex] = FullGameList.sorted(by: {$0.Gen < $1.Gen})
    var body: some View {
        TabView {
            NavigationStack {List {
                Section(content: {
                    ForEach(Regions.allCases) { ThisRegion in
                        StackView(Dex_val: DexManager.DetermineIphoneView(Pokedex: Pokedex, Selection: SidebarVal.region(ThisRegion)))
                    }.padding()
                }, header: {
                    Text("Regions").foregroundStyle(Color.accentColor).font(.largeTitle).textCase(nil)
                })
                Section(content: {
                    ForEach(Games) { Game in
                        StackView(Dex_val: DexManager.DetermineIphoneView(Pokedex: Pokedex, Selection: SidebarVal.Dex(Game)))
                    }.padding()
                }, header: {
                    Text("Dex").foregroundStyle(Color.accentColor).font(.largeTitle).textCase(nil)
                })
            }
    }.tabItem {Label(title: {Text("Dex")}, icon: {Image(systemName: "list.dash").font(.system(size: 50))}) }
                UserView(name: "Romit", email: "romitp")
                    .tabItem {Label(title: {Text("User")}, icon: {Image(systemName: "person.fill").font(.system(size: 50))}) }
        }
    }
}
struct StackView: View {
    var Dex_val: (Pokedex: Binding<[Pokemon_data]>, Region: String,Region_Gradient : LinearGradient)
    var body: some View {
        NavigationLink(destination: PokedexRegionView(Pokedex: Dex_val.Pokedex, Region: Dex_val.Region, Region_Gradient: Dex_val.Region_Gradient), label: {
            Text(Dex_val.Region).font(.title)
        })
    }
}

struct IphoneView_Previews: PreviewProvider {
    static let myobj = DexViewManager()
    static var previews: some View {
        IphoneView(Pokedex: .constant(Pokemon_data.Examples()))
            .environmentObject(myobj)
    }
}

/*
 */
