//
//  ErrorView.swift
//  Pokebase
//
//  Created by romit patel on 9/27/23.
//

import SwiftUI

struct ErrorView: View {
    let errorwrapper: ErrorWrapAble
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorwrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorwrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Dismiss") {
                                    dismiss()
                                }
                            }
                        }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapAble {
        ErrorWrapAble(error: SampleError.errorRequired,
                     guidance: "You can safely ignore this error.")
    }
    
    static var previews: some View {
        ErrorView(errorwrapper: wrapper)
    }
}

