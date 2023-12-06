import SwiftUI
import SwiftData

struct FavoriteListView: View {
    @Query
    var favoritePokemonList:
    [FavoritePokemon] = []
    
    @Environment(\.modelContext)
    private var context
    
    var body: some View {
        NavigationView {
            List{
        
                ForEach(favoritePokemonList, id: \.id) { pokemon in
                    NavigationLink(destination:
                                    FavoriteDetailView(
                                        pokemon: pokemon)){
                                            FavoriteItemView(pokemon: pokemon)
                    }
                    // editMode on List
                }.onDelete{ indexSet in
                    for index in indexSet {
                        context.delete(favoritePokemonList[index])
                    }
                }
            }
        }.navigationTitle("Your favorites")
    }
        
    }

    #Preview {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: FavoritePokemon.self, configurations: config)

        container.mainContext.insert(FavoritePokemon(id: 1, name: "Pikachu", greeting: "heyhooo", nickname: "kachu", height: 1.2, weight: 2.3, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"))

        return FavoriteListView().modelContainer(container)
    }

