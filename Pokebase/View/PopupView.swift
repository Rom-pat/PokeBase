//
//  NavbarView.swift
//  Pokebase
//
//  Created by romit patel on 10/10/23.
//

import SwiftUI

struct PopupView: View {
    @Binding var Pokedex: [Pokemon_data]
    @State private var shiny_list: String  = ""
    @Binding var shiny_count : Int
    var body: some View {
         Button("Cancel",role:.cancel) {
             shiny_list = ""
         }
         Button("On"){
             toggle_all_shinies(pokedex: Pokedex,shiny_list: shiny_list,ShinyOn: true)
             shiny_count = count_mons(Pokedex: Pokedex)
         }
         Button("Off"){
             toggle_all_shinies(pokedex: Pokedex,shiny_list: shiny_list, ShinyOn: false)
             shiny_count = count_mons(Pokedex: Pokedex)
         }
     TextField("Ex. 1-132 or 149", text: $shiny_list)
 
    }
}

#Preview {
    PopupView(Pokedex: .constant(getCSVdata()), shiny_count: .constant(2))
}
