//
//  ContentView.swift
//  Pokedeck
//
//  Created by Franziska Link on 07.11.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var api: PokeApi
    
    init(api: PokeApi){
        self.api = api
    }
    
    var body: some View {
        
        TabView{
            NavigationView{
                SearchListView(pokeApi: PokeApi())
            }

            .tabItem{
            Label("Search", systemImage: "magnifyingglass")
            }
            NavigationView{
                FavoriteListView()
            }
            .tabItem{
                Label("Favorites", systemImage: "star")
            }
            }
        }
    }


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FavoritePokemon.self, configurations: config)

    container.mainContext.insert(FavoritePokemon(id: 1, name: "blau", greeting: "blabla", nickname: "nicki", height: 1.2, weight: 2.3, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"))

    return ContentView(api: PokeApi(mock: false)).modelContainer(container)
}
