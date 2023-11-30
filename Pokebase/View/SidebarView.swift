//
//  SidebarView.swift
//  Pokebase
//
//  Created by romit patel on 9/14/23.
//

import SwiftUI

struct SidebarView: View {
    // Sidebar View
    @EnvironmentObject var UserDetails: User
    @EnvironmentObject var DexManager: DexViewManager
    @State private var hovered: String?
    @State private var Selected: String? = "All"
    var game_dexs: [available_pokedex] = FullGameList.sorted(by: {$0.Gen < $1.Gen})
    var body: some View {
        List(selection: $Selected, content: {
            Button(action: {
                    DexManager.Selected = SidebarVal.Setting
            }, label: {
                Label(title: {Text(UserDetails.UserName).padding()}, icon: {Image(systemName: "person.fill").font(.system(size: 50))})
            }).font(.title)      .foregroundStyle(      DexManager.Selected.return_text() == "Settings" ? CustomColor.sidebarcolors : .accentColor)
            
            
            Section(content: {
                ForEach(Regions.allCases) { key in
                    Button(key.rawValue){
                        DexManager.Selected = SidebarVal.region(key)
                    }.font(.title)
                        .onHover{_ in
                            hovered = key.rawValue
                        }
                        .foregroundStyle(                        DexManager.Selected.return_text() == key.rawValue ? CustomColor.sidebarcolors : .accentColor)
                        .cornerRadius(/*@START_MENU_TOKEN@*/35.0/*@END_MENU_TOKEN@*/)
                        .padding()
                }
            },header: { Text("Regions").foregroundStyle(Color.accentColor).font(.largeTitle).textCase(nil) })
            Section(content: {
                ForEach(game_dexs) { game_dex in
                    Button(game_dex.Name) {
                        DexManager.Selected = SidebarVal.Dex(game_dex)
                    }.font(.title)
                        .onHover{_ in
                        hovered = game_dex.Name
                    }
                        .foregroundStyle(                        DexManager.Selected.return_text() == game_dex.Name ? CustomColor.sidebarcolors : .accentColor)
                    .padding()
                }
            },header: {
                Text("Game Dex").foregroundStyle(Color.accentColor).font(.largeTitle).textCase(nil)
            })
        }).navigationTitle("Pokedex Sidebar").listStyle(.insetGrouped)
         
    }
}

struct SidebarView_Previews: PreviewProvider {
    static let user = User()
    static var previews: some View {
        SidebarView()
            .environmentObject(DexViewManager())
            .environmentObject(user)
    }
}
