//
//  ErrorWrapping.swift
//  Pokebase
//
//  Created by romit patel on 9/27/23.
//

import Foundation

struct ErrorWrapAble: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
