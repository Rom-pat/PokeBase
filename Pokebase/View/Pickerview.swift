//
//  Pickerview.swift
//  Pokebase
//
//  Created by romit patel on 10/14/23.
//

import SwiftUI

struct Pickerview: View {
    @State private var type: String? = "All"
    var types = ["All"] + Type_colors.keys
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Pickerview()
}
