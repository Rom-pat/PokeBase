//
//  ContentViewModel.swift
//  Pokebase
//
//  Created by romit patel on 10/23/23.
//

import Foundation
import SwiftUI

enum SidebarVal: Hashable, Identifiable {
    var id : String {return self.return_text()}
    case region(Regions)
    case Dex(available_pokedex)
    case Setting
    func return_text() -> String{
        switch self {
        case.region(let Reg):
            return Reg.rawValue
        case.Dex(let dex):
            return dex.Name
        case.Setting:
            return "Setting"
        }
    }
}

class DexViewManager: ObservableObject {
    @Published var Selected: SidebarVal
    var RegionalArray:  [SidebarVal] = Regions.allCases.map({SidebarVal.region($0)})
    var DexArray: [SidebarVal] = FullGameList.sorted(by: {$0.Gen < $1.Gen}).map({SidebarVal.Dex($0)})
    init(Selected: SidebarVal = SidebarVal.region(.All)) {
        self.Selected = Selected
    }
    //DetermineDetailView
    func DetermineIpadView(Pokedex: [Pokemon_data]) -> some View {
        switch Selected {
        case .region, .Dex:
            let Dex_val = self.DexDetailView(Pokedex: Pokedex)
            return AnyView(PokedexRegionView(Pokedex: Dex_val.Pokedex, Region: Dex_val.Region, Region_Gradient: Dex_val.Region_Gradient))
        case.Setting:
            return AnyView(UserView())
        }
    }
    func DexDetailView(Pokedex: [Pokemon_data]) -> (Pokedex: Binding<[Pokemon_data]>, Region: String,Region_Gradient : LinearGradient)  {
        switch Selected {
        case .region(let DetailRegion):
            return (ReturnRegionFunc(location: DetailRegion, Pokedex: Pokedex), DetailRegion.rawValue,DetermineGradient())
        case .Dex(let DetailDex):
            return (ReturnGameDex(Pokedex: Pokedex, gameDex: Set(DetailDex.Dex)),DetailDex.Name, DetermineGradient())
        case.Setting:
            return  (ReturnRegionFunc(location: Regions.All, Pokedex: Pokedex), Regions.All.rawValue,DetermineGradient())
        }
    }
    private func DetermineGradient() -> LinearGradient {
        switch Selected {
        case .region(let color_region):
            return LinearGradient(gradient: Gradient(colors: RegionList[color_region]!.colorset), startPoint: .leading, endPoint: .trailing)
        case .Dex(_):
            return LinearGradient(gradient: Gradient(colors: RegionList[.All]!.colorset), startPoint: .leading, endPoint: .trailing)
        case .Setting:
            return LinearGradient(gradient: Gradient(colors: RegionList[.All]!.colorset), startPoint: .leading, endPoint: .trailing)
        }
    }
    
    func DetermineIphoneView(Pokedex: [Pokemon_data], Selection: SidebarVal) -> (Pokedex: Binding<[Pokemon_data]>, Region: String,Region_Gradient : LinearGradient) {
        switch Selection {
        case .region(let DetailRegion):
            return (ReturnRegionFunc(location: DetailRegion, Pokedex: Pokedex), DetailRegion.rawValue,LinearGradient(gradient: Gradient(colors: RegionList[DetailRegion]!.colorset), startPoint: .leading, endPoint: .trailing))
        case .Dex(let DetailDex):
            return (ReturnGameDex(Pokedex: Pokedex, gameDex: Set(DetailDex.Dex)),DetailDex.Name, LinearGradient(gradient: Gradient(colors: RegionList[.All]!.colorset), startPoint: .leading, endPoint: .trailing))
        case.Setting:
            return (ReturnRegionFunc(location: Regions.All, Pokedex: Pokedex), Regions.All.rawValue,LinearGradient(gradient: Gradient(colors: RegionList[.All]!.colorset), startPoint: .leading, endPoint: .trailing))
        }
    }
    //
    func SetSelected(Selected_view: SidebarVal) {
        self.Selected = Selected
    }
}
