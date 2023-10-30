//
//  ContentViewModel.swift
//  Pokebase
//
//  Created by romit patel on 10/23/23.
//

import Foundation
import SwiftUI

enum SidebarVal: Hashable {
    case region(Regions)
    case Dex(available_pokedex)
    func return_text() -> String{
        switch self {
        case.region(let Reg):
            return Reg.rawValue
        case.Dex(let dex):
            return dex.Name
        }
    }
}

class DexViewManager: ObservableObject {
    @Published var Selected: SidebarVal
    var All_names: Set  = [Regions.allCases.map({$0.rawValue})  + available_pokedex.set_game_list().map({$0.Name})]
    init(Selected: SidebarVal = SidebarVal.region(.All)) {
        self.Selected = Selected
    }
    //DetermineDetailView
    func DetermineDetailView(Pokedex: [Pokemon_data]) -> (Pokedex: Binding<[Pokemon_data]>, Region: String,Region_Gradient : LinearGradient)  {
        switch Selected {
        case .region(let DetailRegion):
            return (ReturnRegionFunc(location: DetailRegion, Pokedex: Pokedex), DetailRegion.rawValue,DetermineGradient())
        case .Dex(let DetailDex):
            return (ReturnGameDex(Pokedex: Pokedex, gameDex: Set(DetailDex.Dex)),DetailDex.Name, DetermineGradient())
        }
    }
    //
    func SetSelected(Selected_view: SidebarVal) {
        self.Selected = Selected
    }
    
    private func DetermineGradient() -> LinearGradient {
        switch Selected {
        case .region(let color_region):
            return LinearGradient(gradient: Gradient(colors: RegionList[color_region]!.colorset), startPoint: .leading, endPoint: .trailing)
        case .Dex(_):
            return LinearGradient(gradient: Gradient(colors: RegionList[.All]!.colorset), startPoint: .leading, endPoint: .trailing)
        case nil:
            return LinearGradient(gradient: Gradient(colors: RegionList[.All]!.colorset), startPoint: .leading, endPoint: .trailing)
        }
    }
}
