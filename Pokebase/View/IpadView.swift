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
        NavigationSplitView{
            SidebarView()
        } detail: {
            DexManager.DetermineIpadView(Pokedex: Pokedex)
    }
    }
}

struct IpadView_Previews: PreviewProvider {
    static let myobj = DexViewManager()
    static let user = User()
    static var previews: some View {
        IpadView(Pokedex: .constant(Pokemon_data.Examples()))
            .environmentObject(myobj)
            .environmentObject(user)
    }
}
