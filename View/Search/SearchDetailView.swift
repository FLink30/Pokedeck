//
//  SearchDetailView.swift
//  Pokedeck
//
//  Created by Franziska Link on 28.11.23.

import SwiftUI

struct SearchDetailView: View {
    
    @Environment(\.modelContext)
    private var context
    
    @Environment(\.presentationMode)
    private var presentationMode
   
    @State
    var pokemonId: Int
    @State
    var pokeApi: PokeApi
    @State
    var pokemonDetail: PokeApi.PokemonDetail
    @State
    var nickname: String = ""
    @State
    var greeting: String = ""
    
    
    var body: some View {
        ScrollView{
            VStack{
                PokemonImageView(url: pokemonDetail.imageUrl, background: Color.gray)
                
                VStack(alignment: .leading, spacing: 16){
                    Divider()
                    Text("Name: \(pokemonDetail.name)")
                    Text("Weight: \(String(format: "%.2f",pokemonDetail.weight)) kg" )
                    Text("Height: \(String(format: "%.2f",pokemonDetail.height)) m")
                    Divider()
                    Text("Nickname: ")
                    TextField(
                            "Add Nickname",
                            text: $nickname
                        )
                    Text("Greeting: ")
                    TextField(
                            "Add Greeting",
                            text: $greeting
                        )
                }.padding(16)
                
                Button(action: addPokemonToFavorites){
                    Text("Add to favorites")
                    
                }.padding(16)
            }
        }.onAppear {
            Task{
                let result = await pokeApi.getPokemonDetail(id: pokemonId)
                if let value = result {
                    pokemonDetail = value
                }
            }
        }
    }
    
    func addPokemonToFavorites() -> Void {
     
        let pokemon: FavoritePokemon = FavoritePokemon(id: pokemonId, name: pokemonDetail.name, greeting: self.greeting, nickname: nickname, height: pokemonDetail.height, weight: pokemonDetail.weight, imageUrl: pokemonDetail.imageUrl)
        
            context.insert(pokemon)
            presentationMode.wrappedValue.dismiss()
    }
}

// no modelContainer, because we have access on the container with the context Variable in every view
// we injected the modelcontainer in the root
#Preview {
    SearchDetailView(pokemonId: 1, pokeApi: PokeApi(), pokemonDetail: PokeApi.PokemonDetail(id:1, name: "kp", height: 2.3, weight: 3.2, imageUrl:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"))
}
