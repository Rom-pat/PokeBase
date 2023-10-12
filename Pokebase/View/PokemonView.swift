//
//  PokemonView.swift
//  Pokebase
//
//  Created by romit patel on 9/10/23.
//

import SwiftUI
import Charts
struct PokemonView: View {
    @ObservedObject var thispokemon:Pokemon_data
    @Binding var shiny_count: Int
    @State var Encounter: Int  = 0
    var body: some View {
        List{
            Section(content: {
                HStack {
                    Text(thispokemon.PokemonName)
                    Spacer()
                    Text("#"+String(format: "%04d", thispokemon.id))
                }
            }, header: {SectionHeader(Title: "Name")})
            Section(content: {                Text(thispokemon.Type1)
                if thispokemon.Type2 != "" {
                    Text(thispokemon.Type2)
                }}, header: {SectionHeader(Title: "Types")})
            
            
            Section(content: {
                    Text(thispokemon.Region)
            },header: {SectionHeader(Title: "Discovered Region")})
            
            
            Section(content: {
                Image(thispokemon.display_toggle ? thispokemon.Shiny_image : thispokemon.Poke_image)
                    .padding(.horizontal, 100.0)
            }, header: {SectionHeader(Title: "Current Image Displayed")})
            
            
            Section(content: {
                Button(action: self.toggle_off) {
                    Text(thispokemon.display_toggle ? "Yes" : "No")
                        .font(.title2)
                        .foregroundColor(thispokemon.display_toggle ? Color.green : Color.red)
                }
            },header: {SectionHeader(Title:  "Shiny variant caught?")})
            
            
            if thispokemon.display_toggle {
                Section(content: {
                    DatePicker(
                        selection: $thispokemon.date,
                    displayedComponents: [.date]
                    ){Text("Caught Shiny Date")}
                },header: {SectionHeader(Title: "Catch Date")})
            }
            Section(content: {
                Stepper("Encounters:  \(Encounter)", value: $Encounter)},
                    header:{SectionHeader(Title: "Encounters")})

            
            Section(content: {
                Chart {
                    ForEach(thispokemon.pokestats) { Stats in
                        BarMark(
                            x: .value("Shape Type", Stats.Stat),
                            y: .value("Total Count", Stats.value)
                        ).annotation{
                            Text(String(Stats.value))
                        }
                        .foregroundStyle(by: .value("Shape Color", Stats.color))
                        
                    }
                    
                }
                .chartLegend(.hidden)
                .chartForegroundStyleScale([
    "Green": .green, "Purple": .purple, "Red": .red, "Yellow": .yellow,"Orange" : .orange, "Blue": .blue
                ])
            }, header: {SectionHeader( Title:"Stat Spread")})
            
            
            Section(content: {
                Link("Bulbapedia Link", destination: URL(string:                 "https://bulbapedia.bulbagarden.net/wiki/"+thispokemon.PokemonName.replacingOccurrences(of: " ", with: "_"))!)
                    .font(.title)
                    .foregroundStyle(.blue)
            }, header: {SectionHeader(Title: "Possible locations")})
            
        }.onAppear(perform: {
            Encounter = thispokemon.step
        })
        .onDisappear(perform: {
            thispokemon.step = Encounter
        })
        .scrollContentBackground(.hidden)
            .background(LinearGradient(gradient: Gradient(colors: pokemon_colors), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var zekrom = getCSVdata()[643]
    static var previews: some View {
        PokemonView(thispokemon: zekrom, shiny_count: .constant(0))
    }
}

private extension PokemonView {
    func toggle_off() {
        self.thispokemon.set_toggle()
        shiny_count += thispokemon.display_toggle ? 1  : -1
    }
    var pokemon_colors : [Color] {
        var color = [
            Type_colors[thispokemon.Type1]!
        ]
        if thispokemon.Type2 != "" {
            color.append(            Type_colors[thispokemon.Type2]!)
        }
        return color
    }
}
