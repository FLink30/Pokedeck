//
//  FavoritePokemon.swift
//  Pokedeck
//
//  Created by Franziska Link on 07.11.23.
//

import Foundation
import SwiftData

@Model
class FavoritePokemon: Identifiable{
    
    var id: Int
    var name: String
    var greeting: String
    var nickname: String
    var height: Double
    var weight: Double
    var imageUrl: String
    
    
    init(id: Int, name: String, greeting: String, nickname: String, height: Double, weight: Double, imageUrl: String){
        self.id = id
        self.name = name
        self.greeting = greeting
        self.nickname = nickname
        self.height = height
        self.weight = weight
        self.imageUrl = imageUrl
    }

}

