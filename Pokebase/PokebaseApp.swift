//
//  PokebaseApp.swift
//  Pokebase
//
//  Created by romit patel on 9/10/23.
//

import SwiftUI
@main
struct PokebaseApp: App {
    @StateObject  private var Store = PokedexStore()
    @State private var errorWrapper: ErrorWrapAble?
    var body: some Scene {
        WindowGroup {
            ContentView(Pokedex: $Store.PokedexStore) {
                Task {
                    do {
                        try await Store.save(pokedex_val: Store.PokedexStore)
                    } catch {
                        errorWrapper = ErrorWrapAble(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }
                .task {
                    do {try await Store.load()
                        if Store.PokedexStore.isEmpty{
                            Store.PokedexStore = getCSVdata()
                        }
                    } catch {
                        errorWrapper = ErrorWrapAble(error: error,
                                                    guidance: "Loading in original data.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    Store.PokedexStore = getCSVdata()
                } content: { wrapper in
                    ErrorView(errorwrapper: wrapper)
                }
        }
    }
}
