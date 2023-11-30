//
//  Pokemon.swift
//  Pokebase
//
//  Created by romit patel on 9/10/23.
//

import Foundation
import SwiftUI
import SwiftCSV
//POKEMON DATA
class Pokemon_data: ObservableObject, Identifiable, Codable{
    init(dataum: Array<String> ) {
        self.id = Int(dataum[0].replacingOccurrences(of: "#", with: "")) ?? 0
        self.PokemonName = dataum[1]
        self.Type1 = dataum[2].capitalized
        self.Type2 = dataum[3].capitalized
        self.Abilites = dataum[4].components(separatedBy: ",")
        pokestats = return_spread(dataum: dataum)
        self.Poke_image = "HOME" + String(format: "%04d", id)
        self.Shiny_image = self.Poke_image + "_s"
        self.Region = ""
    }
    var id: Int
    var PokemonName: String
    var Poke_image: String
    var Shiny_image: String
    var Type1: String
    var Type2: String
    var Abilites: [String]
    var pokestats: [StatSpread]
    var date: Date = Date.now
    @Published var step: Int = 0
    @Published var display_toggle: Bool = false
    var Region: String
    func set_toggle() {
        self.display_toggle.toggle()
        if display_toggle {
            date = Date.now
        }
    }
    func toggle_on() {
        self.display_toggle = true
    }
    func toggle_off() {
        self.display_toggle = false
    }
    static func Examples() -> [Pokemon_data] {
        var Pokedex = [Pokemon_data]()
        do {
            guard let filepath = Bundle.main.path(forResource: "Updated_pokemon", ofType: "tsv")
            else {
                print("here")
                return []
            }
            let tsv : CSV =  try CSV<Enumerated>(url: URL(fileURLWithPath: filepath), delimiter: .tab, loadColumns: false)
            for poke in tsv.rows {
                        let pokemon = Pokemon_data(dataum: poke)
                        pokemon.Region = region_place(poke: pokemon)
                        Pokedex.append(pokemon)
            }
        }catch {
            print(error)
            return []
        }
        return Pokedex
    }
    func cleandata(file:String) -> String {
        var cleanfile = file
        cleanfile = cleanfile.replacingOccurrences(of: "\r", with: "\n")
        cleanfile = cleanfile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanfile
        
    }
    enum CodingKeys: CodingKey {
        case id
        case PokemonName
        case Poke_image
        case Shiny_image
        case Type1
        case Type2
        case Abilites
        case pokestats
        case date
        case step
        case display_toggle
        case Region
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.PokemonName = try container.decode(String.self, forKey: .PokemonName)
        self.Poke_image = try container.decode(String.self, forKey: .Poke_image)
        self.Shiny_image = try container.decode(String.self, forKey: .Shiny_image)
        self.Type1 = try container.decode(String.self, forKey: .Type1)
        self.Type2 = try container.decode(String.self, forKey: .Type2)
        self.Abilites = try container.decode([String].self, forKey: .Abilites)
        self.pokestats = try container.decode([StatSpread].self, forKey: .pokestats)
        self.date = try container.decode(Date.self, forKey: .date)
        self.step = try container.decode(Int.self, forKey: .step)
        self.display_toggle = try container.decode(Bool.self, forKey: .display_toggle)
        self.Region = try container.decode(String.self, forKey: .Region)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.PokemonName, forKey: .PokemonName)
        try container.encode(self.Poke_image, forKey: .Poke_image)
        try container.encode(self.Shiny_image, forKey: .Shiny_image)
        try container.encode(self.Type1, forKey: .Type1)
        try container.encode(self.Type2, forKey: .Type2)
        try container.encode(self.Abilites, forKey: .Abilites)
        try container.encode(self.pokestats, forKey: .pokestats)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.step, forKey: .step)
        try container.encode(self.display_toggle, forKey: .display_toggle)
        try container.encode(self.Region, forKey: .Region)
    }
    
}

private func region_place(poke: Pokemon_data) -> String {
    for region in RegionList{
        if region.value.RegionDex.contains(poke.id) {
            return region.key.rawValue
        }
    }
    return "Unkown Region"
}

func All_photo(Dex: Int) -> [String] {
    var Image_Container: [String] = []
    let fileMang = FileManager.default
    let enumerator = fileMang.enumerator(atPath: Bundle.main.bundlePath)
    let filepaths = enumerator?.allObjects as! [String]
    Image_Container = filepaths.filter{ $0.contains(String(format: "%04d", Dex))}
    print(Image_Container)
    return Image_Container
}
