//
//  Pokedex_info.swift
//  Pokebase
//
//  Created by romit patel on 10/22/23.
//

import Foundation
import SwiftUI


enum Regions: String,CaseIterable, Identifiable {
    case All,Kanto, Johto, Hoenn, Sinnoh, Unova, Kalos, Alola, Galar, Hisui, Paldea, Unkown
    var id : String {return self.rawValue}
    
}


enum Form :String, CaseIterable, Identifiable {
    case All, Shinies, NonShinies
    var id: Self { self }
}


func ReturnRegionFunc(location: Regions, Pokedex: [Pokemon_data]) -> Binding<[Pokemon_data]> {
    if  location  == .All {
        return .constant(Pokedex)
    }
    return .constant(Pokedex.filter({
        Pokemon in Pokemon.Region == location.rawValue
    }))
}

func ReturnGameDex(Pokedex: [Pokemon_data], gameDex: Set<Int>) -> Binding<[Pokemon_data]>{
    return .constant(Pokedex.filter({ gameDex.contains($0.id)
    }))
}

func count_mons(Pokedex: [Pokemon_data]) -> Int {
    return Pokedex.filter({$0.display_toggle == true}).count
}

private func check_range(pokedex: [Pokemon_data], dex_number: Int ) -> Bool {
    if dex_number > pokedex[pokedex.count-1].id || dex_number < pokedex[0].id {
        return false
    }
    return true
}


func toggle_all_shinies(pokedex : [Pokemon_data], shiny_list: String, ShinyOn: Bool) {
    let AllShiny  = shiny_list.filter{!$0.isWhitespace}.components(separatedBy: ",")
    for shiny in AllShiny{
        if shiny.contains("-") {
            let AllMons = shiny.components(separatedBy: "-")
            if Int(AllMons[0]) != nil && Int(AllMons[1]) != nil && check_range(pokedex: pokedex, dex_number: Int(AllMons[0])!) &&
                check_range(pokedex: pokedex, dex_number: Int(AllMons[1])!) && Int(AllMons[1])! > Int(AllMons[0])! {
                for mon in (Int(AllMons[0])!) ... (Int(AllMons[1])!) {
                    if ShinyOn{
                        pokedex.filter({$0.id == mon})[0].toggle_on()
                    }
                    else {
                        pokedex.filter({$0.id == mon})[0].toggle_off()
                    }
                }
            }
        }
        else if Int(shiny) != nil && check_range(pokedex: pokedex, dex_number: Int(shiny)!) {
            if ShinyOn{
                pokedex.filter({$0.id == Int(shiny)!})[0].toggle_on()
            }
            else {
                pokedex.filter({$0.id == Int(shiny)!})[0].toggle_off()
            }
        }
    }
}

// GAME REGIONS DEXS
struct available_pokedex: Identifiable, Codable, Hashable{
    let id: UUID = UUID()
    var Name: String
    var Dex: [Int]
    var Gen: Int
    static func set_game_list() -> [available_pokedex] {
        var available_dex : [available_pokedex] = []
        if let data = region_loader(filename: "RegionalDex.json") {
            if let data2 = parse_Data(jsonData: data) {
                available_dex = data2
            }
        }
        return available_dex
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Name = try container.decode(String.self, forKey: .Name)
        self.Dex = try container.decode([Int].self, forKey: .Dex)
        self.Gen = try container.decode(Int.self, forKey: .Gen)
    }
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
let FullGameList = available_pokedex.set_game_list()
