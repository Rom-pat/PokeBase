//
//  UserModel.swift
//  Pokebase
//
//  Created by romit patel on 9/20/23.
//

import Foundation
import CryptoKit
import SwiftUI
class User: ObservableObject {
    var Photo: Image = Image(systemName: "person.fill")
    @AppStorage("LoginName") var LoginName: String = ""
    @AppStorage("UserName") var UserName: String = ""
    @AppStorage("Email") var Email: String = ""
    @AppStorage("Dark mode") var darkMode : Bool = UserDefaults.standard.bool(forKey: "Dark mode")
    @AppStorage("IsFavorite") var  IsFavorite: Int = 1
    @AppStorage("IsShiny") var IsShiny: Bool = false
    @AppStorage("Gen6ShinyCharm") var Gen6ShinyCharm = false
    @AppStorage("Gen7ShinyCharm") var Gen7ShinyCharm = false
    @AppStorage("Gen8ShinyCharm") var Gen8ShinyCharm = false
    @AppStorage("Gen9ShinyCharm") var Gen9ShinyCharm = false
    var SignupDate = Date.now
    var UserDex = PokedexStore()
    
}
class PokedexStore: ObservableObject {
    @Published var PokedexStore: [Pokemon_data] = []
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("Pokedex.data")
    }
    @MainActor func load() async throws {
        let task = Task<[Pokemon_data], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let Pokemon = try JSONDecoder().decode([Pokemon_data].self, from: data)
            return Pokemon
        }
        let PokedexStore = try await task.value
        self.PokedexStore = PokedexStore 
    }
    
    
    func save(pokedex_val: [Pokemon_data]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(pokedex_val)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
