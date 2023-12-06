//
//  Item.swift
//  Pokedeck
//
//  Created by Franziska Link on 07.11.23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
