//
//  UserView.swift
//  Pokebase
//
//  Created by romit patel on 10/28/23.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var UserDetails: User
    @State var IsPopup: Bool = false
    var FavPokemon: Pokemon_data {
        let dex = Pokemon_data.Examples()
        return dex.filter({$0.id == UserDetails.IsFavorite})[0]
    }
    var body: some View {
        NavigationStack {
                List {
                    HStack {
                        UserDetails.Photo.font(.largeTitle)
                        Spacer()
                        VStack {
                            Spacer()
                            Text("Caught \(count_mons(Pokedex:UserDetails.UserDex.PokedexStore))/\(UserDetails.UserDex.PokedexStore.count)")
                            Spacer()
                            Text("Email: \(UserDetails.Email)")
                            Spacer()
                            Text("Started on: \n \(UserDetails.SignupDate, format: .dateTime.day().month().year())")
                            Toggle(isOn: UserDetails.$darkMode, label: {Text("Turn on Dark Mode")}).controlSize(.mini)
                        }
                        Spacer()
                       
                    }
                        Section(header: Text("Favorite Pokémon").textCase(nil).font(.largeTitle)) {
                                HStack {
                                    Image(UserDetails.IsShiny ? FavPokemon.Shiny_image :  FavPokemon.Poke_image)
                                    Text(FavPokemon.PokemonName).font(.largeTitle).bold()
                                }
                            }
                    Section(header: Text("Latest Hunt").textCase(nil).font(.largeTitle)) {
                        HStack {
                            VStack {
                                Image("HOME" + String(format: "%04d", 493))
                                Text("Encounters: 2500")
                            }
                            VStack {
                                Image("HOME" + String(format: "%04d", 495))
                                Text("Encounters: 2500")
                            }
                            VStack {
                                Image("HOME" + String(format: "%04d", 644))
                                Text("Encounters: 2500")
                            }
                        }
                    }
                }.navigationTitle("\(UserDetails.UserName) Profile")
                .toolbar(content: {
                        Button("Edit"){
                            IsPopup = true
                        }.font(.title).foregroundColor(.blue)
                })
                .sheet(isPresented: $IsPopup) {
                    NavigationStack {
                        UserEditView(Ispopup: $IsPopup)
                    }
                }
        }
    }
}

struct UserEditView: View {
    @Binding var Ispopup: Bool
    @EnvironmentObject var UserDetails: User
    @State var name : String = ""
    @State var email : String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Current Name:  \(UserDetails.UserName)")) {
                TextField("Modify Name", text: $name)
                
            }
            Section(header: Text("Current Email:  \(UserDetails.Email)")) {
                TextField("Modify Email", text: $email)
            }
            Section(header: Text("Change Favorite Pokemon")) {
                Picker("Favorite Pokemon",  selection: $UserDetails.IsFavorite){
                    ForEach(UserDetails.UserDex.PokedexStore) {pokemon in
                        Text("\(pokemon.PokemonName)").tag(pokemon.id)
                    }
                }
                Toggle("Shiny or Normal", isOn: $UserDetails.IsShiny)
            }
            
        }
        .toolbar { ToolbarItem(placement: .cancellationAction) {  Button("Cancel") {
            Ispopup = false
        }.foregroundStyle(Color.blue)
        }
            ToolbarItem(placement: .confirmationAction, content: {  Button("Confirm") {
                Ispopup = false
                UserDetails.UserName = (!name.isEmpty) ? name : UserDetails.UserName
                UserDetails.Email = (!email.isEmpty) ? email : UserDetails.Email
            }.foregroundStyle(Color.blue)
            })
    }
    }
}
#Preview {
    UserView().environmentObject(User())
}

/*
 UserDetails.Photo.font(.largeTitle)
 List {
 Text("User: \(UserDetails.LoginName)")
 Text("Email: \(UserDetails.Email)")
 Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
 Text(UserDetails.SignupDate, format: .dateTime.day().month().year())
 Toggle(isOn: UserDetails.$darkMode, label: {Text("Turn on Dark Mode")}).controlSize(.mini)
 }
 
 
 Button(action: {
 IsPopup = true
 }, label: {Label("Edit", systemImage: "pencil")})
 */
 
