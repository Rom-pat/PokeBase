//
//  IpadView.swift
//  Pokebase
//
//  Created by romit patel on 10/19/23.
//

import SwiftUI

struct IpadView: View {
    @Binding var Pokedex: [Pokemon_data]
    @EnvironmentObject var DexManager: DexViewManager
    var body: some View {
        let PokedexArgs = DexManager.DetermineDetailView(Pokedex: Pokedex)
            TabView {
                NavigationSplitView{
                    SidebarView(SelectedVal: $DexManager.Selected)
                } detail: {
                PokedexRegionView(Pokedex: PokedexArgs.Pokedex, PokedexRegionVM: PokedexRegionView.PokedexViewModel(),Region: PokedexArgs.Region, Region_Gradient: PokedexArgs.Region_Gradient)
            }
                .tabItem {Label(title: {Text("Dex")}, icon: {Image(systemName: "list.dash").font(.system(size: 50))}) }
                UserView(name: "Romit", email: "romitp")
                    .tabItem {Label(title: {Text("User")}, icon: {Image(systemName: "person.fill").font(.system(size: 50))}) }
            }
    }
}

struct IpadView_Previews: PreviewProvider {
    static let myobj = DexViewManager()
    static var previews: some View {
        IpadView(Pokedex: .constant(Pokemon_data.Examples()))
            .environmentObject(myobj)
    }
}
