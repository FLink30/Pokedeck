import SwiftUI
 
struct FavoriteItemView: View{
   
    
var pokemon: FavoritePokemon

 var body: some View {
     HStack(alignment: .center, spacing: 30) {
         PokemonImageView(url: pokemon.imageUrl, background: Color.gray, size: 100)
         Text(pokemon.name).bold()
     }
 }
 
 }
 
 #Preview {
     FavoriteItemView(pokemon: FavoritePokemon(
        id: 1,
        name: "Pikachu",
        greeting: "blabla",
        nickname: "nicki",
        height: 0.4,
        weight: 200.0,
        imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"))
 }
 
