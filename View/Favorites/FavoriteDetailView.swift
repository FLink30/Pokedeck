//
//  FavoriteDetailView.swift
//  Pokedeck
//
//  Created by Franziska Link on 07.11.23.
//

import SwiftUI

struct FavoriteDetailView: View {
   
    var pokemon: FavoritePokemon
    
    @Environment(\.modelContext)
    private var context
    
    @Environment(\.presentationMode)
    private var presentationMode

    @State
    var showAlter = false
    
    var body: some View {
        ScrollView{
            VStack(){
                
                PokemonImageView(url: pokemon.imageUrl, background: Color.gray)
                
                VStack(alignment: .leading, spacing: 16){
                    Divider()
                    Text("Nickname: \(pokemon.nickname)")
                    Text("Greeting: \(pokemon.greeting)")
                    Divider()
                    Text("Name: \(pokemon.name)")
                    Text("Weight: \(String(format: "%.2f",pokemon.weight)) kg" )
                    Text("Height: \(String(format: "%.2f",pokemon.height)) m")
                }.padding(16)
            }
        }
    
        // wont be displayed in the preview - reason: toolbar is part of the NavigationController - therefore we have to open the preview on level higher
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    showAlter = true
                }, label: {
                    Image(systemName: "trash").foregroundColor(.red)
                })
            }
        }
        .alert("Do you really want to delete the pokemon?",
               isPresented: $showAlter){
                Button(role: .destructive) {
                    deletePokemon() } label: {
                    Label("Delete", systemImage: "trash")
                }
                Button(role: .cancel) {} label: {
                    Label("Nooo, poor little pokemon", systemImage: "trash")
                }
   
           
        }message: {
                Text("bla")
            }
        
    }
    
    func deletePokemon()-> Void {
        context.delete(pokemon)
        presentationMode.wrappedValue.dismiss()
        
    }
}

#Preview {
   FavoriteDetailView(pokemon: FavoritePokemon(id: 1, name: "Pikachu",greeting: "blabla",nickname: "nicki", height: 0.4, weight: 200.0, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"))
}

