//
//  PokemonSearchListItem.swift
//  Pokedeck
//
//  Created by Franziska Link on 28.11.23.
//

import SwiftUI

struct SearchItemView: View {
    var pokemonListItem: PokeApi.PokemonListItem
    var body: some View {
        VStack{
            PokemonImageView(url: pokemonListItem.imageUrl,background: Color.gray)
            Text(pokemonListItem.name)
            
        }.padding(20)
    }
}

#Preview {
    SearchItemView(pokemonListItem: PokeApi.PokemonListItem(
        id: 1,
        name: "Pikachu",
        imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"))
}
