//
//  SearchListView.swift
//  Pokedeck
//
//  Created by Franziska Link on 28.11.23.
//
import SwiftUI
import SwiftData

struct SearchListView: View {
    var pokeApi: PokeApi
    
    // SwiftUI manages the property storage
    // if value of variable changes, swiftui renders changed data
    @State
    var searchText: String = ""
    
    @State
    private var allPokemonList: [PokeApi.PokemonListItem] = []
    
    @State
    var filteredPokemonList: [PokeApi.PokemonListItem] = []
    
    var body: some View {
        NavigationView{
            ScrollView{
                TextField("Search for a pokemon", text: $searchText)
                    .padding(8)
                    .background(.thinMaterial)
                    .cornerRadius(10.0)
                    .onChange(of: searchText){
                     filteredPokemonList(pokemonName: searchText)
                    }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))]) {
                    // ForEach(collection, id: \.self){ element in
                    // Ansicht für jedes Element:
                    // Text(element.title)
                    
                    // warum geht hier nur ForEach und nicht List()
                    ForEach(filteredPokemonList, id: \.self){
                        pokemon in NavigationLink(
                            destination:
                                SearchDetailView(
                                    pokemonId: pokemon.id,
                                    pokeApi: PokeApi(),
                                    pokemonDetail: PokeApi.PokemonDetail(id: pokemon.id))) {
                                        SearchItemView(pokemonListItem: pokemon)
                                    }
                    }
                }
            }.navigationTitle("Search for a pokemon")
        }
        .onAppear {
            // Task verwendet man nur innerhalb eines Views
            Task{
                let result = await pokeApi.getPokemonList()
                if let value = result {
                    allPokemonList = value
                    filteredPokemonList = allPokemonList
                }
            }
        }
    }
    
    func filteredPokemonList(pokemonName: String) {
        if pokemonName.isEmpty{
            filteredPokemonList = allPokemonList
        }else{
            filteredPokemonList = allPokemonList.filter{$0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview {
    SearchListView(pokeApi: PokeApi(mock: true))
}
