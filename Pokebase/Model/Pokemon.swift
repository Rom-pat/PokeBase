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
    var step: Int = 0
    var display_toggle: Bool = false
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
}
func cleandata(file:String) -> String {
    var cleanfile = file
    cleanfile = cleanfile.replacingOccurrences(of: "\r", with: "\n")
    cleanfile = cleanfile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanfile
    
}

private func region_place(poke: Pokemon_data) -> String {
    for region in RegionList{
        if region.value.RegionDex.contains(poke.id) {
            return region.key.rawValue
        }
    }
    return "Unkown Region"
}
func getCSVdata() -> [Pokemon_data]  {
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


// GAME REGIONS DEXS
struct available_pokedex: Identifiable, Codable{
    let id = UUID()
    var Name: String
    var Dex: [Int]
    var Gen: Int
}


private func region_loader(filename: String) -> Data?  {
    var jsonData : Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("stuck here")
        return nil
    }
    do {
        jsonData = try Data(contentsOf: file)
        return jsonData
    }
    catch {
        print(error)
    }
    return nil
}

private func parse_Data(jsonData: Data) -> [available_pokedex]? {
    do {
        let decoding = try JSONDecoder().decode([available_pokedex].self, from: jsonData)
        return decoding
    }
    catch {
        print(error)
    }
    return nil
}

func set_game_list() -> [available_pokedex] {
    var available_dex : [available_pokedex] = []
    if let data = region_loader(filename: "RegionalDex.json") {
        if let data2 = parse_Data(jsonData: data) {
            available_dex = data2
        }
    }
    return available_dex
}
let FullGameList = set_game_list()
