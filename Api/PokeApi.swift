//
//  PokeApi.swift
//  Pokedeck
//
//  Created by Franziska Link on 28.11.23.
//

import Foundation
import SwiftUI

struct PokeApi{
    var mock: Bool
    
    
    init(mock: Bool = false) {
        self.mock = mock
    }
    
    func getPokemonList() async -> [PokemonListItem]?{
        let pokemonList: [PokemonListItem]?
        if(mock){
        pokemonList = [
           PokemonListItem(id: 25, name: "Pikachu", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"),
           PokemonListItem(id: 1, name: "Bulbasaur", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
           PokemonListItem(id: 4, name: "Charmander", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"),
           PokemonListItem(id: 7, name: "Squirtle", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png")
           ]
       return pokemonList
        }else{
            pokemonList = await HttpApi.getPokemonList()
        }
        return pokemonList
        }
    
    func getPokemonDetail(id: Int) async -> PokemonDetail?{
        let pokemon: PokemonDetail?
        if (mock){
            pokemon = PokemonDetail(id: id, name: "blq", height: 2.3, weight: 3.4, imageUrl:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png" )
        }else{
            pokemon = await HttpApi.getPokemonDetail(id: id)
        }
        return pokemon
    }
    
    /*func getFavoritePokemon(id: Int) async -> FavoritePokemon?{
        let pokemon: FavoritePokemon?
        if(mock){
            pokemon = FavoritePokemon(id: 1, name: "bla", greeting: "blabla", nickname: "nicki", height: 1.2, weight: 2.3, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")
        }else{
            pokemon = await HttpApi.getFavoritePokemon(id: id)
        }
        return pokemon
    }
    */
    
    
    // muss Protocol Identifiable implementieren, da die Klasse PokemonListItem, stets eindeutig identifizierbar sein soll... vor allem im Datenbankkontext, auch wenn sich andere daten ändern
    // Identifiable garantiert dies, weil die Klasse eine eindeutig identifizierbare Id benötigt um mit Identifiable
    // konform zu sein
    struct PokemonListItem: Identifiable, Hashable {
        static func == (lhs: PokemonListItem, rhs: PokemonListItem) -> Bool {
                return lhs.id == rhs.id
            }

        var id: Int
        var name: String
        var imageUrl: String
        
        
    }
    
    struct PokemonDetail{
        var id: Int
        var name: String = ""
        var height: Double = 0.0
        var weight: Double = 0.0
        var imageUrl: String = ""
        
        init(id: Int){
            self.id = id
        }
    
        
        init(id: Int, name: String, height: Double, weight: Double, imageUrl: String){
            self.id = id
            self.name = name
            self.height = height
            self.weight = weight
            self.imageUrl = imageUrl
        }
    }
}
