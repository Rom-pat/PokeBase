//
//  UserView.swift
//  Pokebase
//
//  Created by romit patel on 10/28/23.
//

import SwiftUI

struct UserView: View {
    @State var name: String
    @State var email: String
    var body: some View {
        Text("User: \(name)")
        Text("User: \(email)")
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
    }
}

#Preview {
    UserView(name: "Romit", email: "Romit@gmail.com")
}
