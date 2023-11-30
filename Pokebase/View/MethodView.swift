//
//  MethodView.swift
//  Pokebase
//
//  Created by romit patel on 11/18/23.
//

import SwiftUI

struct MethodView: View {
    @EnvironmentObject var UserDetails: User
    @StateObject var MethodVM = MethodViewModel()
    @State var Lure = false
    var body: some View {
        VStack {
            Text("Method Rates and Shiny Charm")
            List {
                Section(content: {
                    Toggle(isOn: $UserDetails.Gen6ShinyCharm, label: {
                        Text("Gen6")
                    }).tint(Color.green)
                    Toggle(isOn: $UserDetails.Gen7ShinyCharm, label: {
                        Text("Gen7")
                    }).tint(Color.yellow)
                    Toggle(isOn: $UserDetails.Gen8ShinyCharm, label: {
                        Text("Gen8")
                    }).tint(Color.teal)
                    Toggle(isOn: $UserDetails.Gen9ShinyCharm, label: {
                        Text("Gen9")
                    }).tint(Gradient(colors: [Color(hex: 0xc91421),Color(hex: 0x632ea6)]))
                },header: {Text("Shiny Charms").font(.headline)})
                Section(content: {
                    HStack(content: {
                        Text("Gen4")
                        Spacer()
                        Text("1/\(MethodVM.MasudaMethod(rate: 8192, ShinyCharm: false, Reroll: 4))")
                    })
                    HStack(content: {
                        Text("Gen5")
                        Spacer()
                        Text("1/\(MethodVM.MasudaMethod(rate: 8192, ShinyCharm: false, Reroll: 5))")
                    })
                    HStack(content: {
                        Text("Gen5 + ShinyCharm")
                        Spacer()
                        Text("1/\(MethodVM.MasudaMethod(rate: 8192, ShinyCharm: true, Reroll: 5))")
                    })
                    HStack(content: {
                        Text("Gen 6-Current")
                        Spacer()
                        Text("1/\(MethodVM.MasudaMethod(rate: 4096, ShinyCharm: false, Reroll: 5))")
                    })
                    HStack(content: {
                        Text("Gen 6-Current + Shiny Charm")
                        Spacer()
                        Text("1/\(MethodVM.MasudaMethod(rate: 4096, ShinyCharm: true, Reroll: 5))")
                    })
                }, header: {Text("Masuda Method").font(.headline)})
                Section(content: {
                        Slider(value: $MethodVM.FourRadar, in: 0...40, step: 1,label: {Text("Current Chance")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("40")}).tint(Color.blue)
                        HStack {
                            Button(action: {MethodVM.FourRadar = 0.0}, label: {Text("Reset").font(.headline).foregroundStyle(Color.blue)})
                            Spacer()
                            Text("Chain Step: " + String(MethodVM.FourRadar))
                        }
                        Text("Gen 4 Shiny Rate: 1/\(MethodVM.Gen4Radar()) per patch")
                        Text("Gen 6 Shiny Rate: 1/\(MethodVM.Gen4Radar()/2) per patch ")
                        Text("Gen 8 Shiny Rate: \(MethodVM.Gen8Radar()) per patch")
                },header: {Text("Poke Radar").font(.headline)})
                Section(content: {
                },header: {Text("Dex Nav (Gen 6)").font(.headline)})
                Section(content: {
                    Slider(value: $MethodVM.ChainFishingChance, in: 0...20, step: 1,label: {Text("Current Chance")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("20")}).tint(Color.blue)
                    HStack {
                        Button(action: {MethodVM.ChainFishingChance = 0.0}, label: {Text("Reset").font(.headline).foregroundStyle(Color.blue)})
                        Spacer()
                        Text("Chain Step: \(MethodVM.ChainFishingChance, specifier: "%.0f")")
                    }
                    Text("Shiny Rate: 1/\(MethodVM.FishChance(ShinyCharm: UserDetails.Gen6ShinyCharm))")
                },header: {Text("Chain Fishing (Gen 6)").font(.headline)})
                Section(content: {
                    Slider(value: $MethodVM.SOSChain, in: 0...31, step: 1,label: {Text("Current Chance")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("31")}).tint(Color.blue)
                    HStack {
                        Button(action: {MethodVM.SOSChain = 0.0}, label: {Text("Reset").font(.headline).foregroundStyle(Color.blue)})
                        Spacer()
                        Text("Chain Step: " + String(MethodVM.SOSChain))
                    }
                    Text("Shiny Odds: "+MethodVM.SOS(ShinyCharm: UserDetails.Gen7ShinyCharm))
                },header: {Text("SOS Battle (S/M & US/UM)").font(.headline)})
                Section(content: {
                    Slider(value: $MethodVM.CatchChain, in: 0...31, step: 1,label: {Text("Current Chance")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("31")}).tint(Color.blue)
                    HStack {
                        Button(action: {MethodVM.CatchChain = 0.0}, label: {Text("Reset").font(.headline).foregroundStyle(Color.blue)})
                        Spacer()
                        Text("Chain Step: " + String(MethodVM.CatchChain))
                    }
                    Toggle(isOn: $Lure, label: {
                        Text("Lure")
                    }).tint(Color.green)
                    Text("Shiny Odds: "+MethodVM.CatchCombo(ShinyCharm: UserDetails.Gen7ShinyCharm, Lure: Lure))
                },header: {Text("Catch Combo (LGP/LGE)").font(.headline)})
                Section(content: {
                    Text("Regular Odds: 1/300")
                    Text("Odds w/ Shiny Charm: 1/100")
                },header: {Text("Dynamax Adventure (Gen 8)").font(.headline)})
            }.listStyle(.sidebar)
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct MethodView_Previews: PreviewProvider {
    static let user = User()
    static var previews: some View {
        MethodView()
            .environmentObject(user)
    }
}
