//
//  PokebaseApp.swift
//  Pokebase
//
//  Created by romit patel on 9/10/23.
//

import SwiftUI
@main
struct PokebaseApp: App {
    @StateObject private var CurrentUser = User()
    @State private var errorWrapper: ErrorWrapAble?
    @State private var loading  = false
    var body: some Scene {
        WindowGroup {
            ContentView(Pokedex: $CurrentUser.UserDex.PokedexStore) {
                Task {
                    do {
                        try await CurrentUser.UserDex.save(pokedex_val: CurrentUser.UserDex.PokedexStore)
                    } catch {
                        errorWrapper = ErrorWrapAble(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }
                .task {
                    do {try await CurrentUser.UserDex.load()
                        if CurrentUser.UserDex.PokedexStore.isEmpty{
                            CurrentUser.UserDex.PokedexStore = Pokemon_data.Examples()
                        }
                    } catch {
                        errorWrapper = ErrorWrapAble(error: error,
                                                    guidance: "Loading in original data.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    CurrentUser.UserDex.PokedexStore = Pokemon_data.Examples()
                } content: { wrapper in
                    ErrorView(errorwrapper: wrapper)
                }
                .environmentObject(CurrentUser)
                /*.preferredColorScheme(CurrentUser.darkMode ? .dark : .light)*/
        }
    }
}
