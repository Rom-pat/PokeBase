//
//  ContentView.swift
//  Pokebase
//
//  Created by romit patel on 9/10/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var Pokedex: [Pokemon_data]
    @StateObject var DexManager = DexViewManager()
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac{
            IpadView(Pokedex: $Pokedex)        .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
            .environmentObject(DexManager)
        }
        else if UIDevice.current.userInterfaceIdiom == .phone {
            IphoneView(Pokedex: $Pokedex)
            .environmentObject(DexManager)
        }
            
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(Pokedex: .constant(Pokemon_data.Examples()), saveAction: {})
    }
}
