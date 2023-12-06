//
//  HttpApi.swift
//  Pokedeck
//
//  Created by Franziska Link on 28.11.23.
//

import Foundation

class HttpApi {
    // ERROR
    private enum ApiError: Error {
        case invalidUrl
        case unexpectedStatusCode
        case connectionFailed
        case invalidJSON
    }

    private static let pokeAPIBaseURL = "https://pokeapi.co/api/v2"
    private static let pokeAPIImageBaseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon"
    
    // Was wir von der API ziehen muss decodable implementieren
    
    // Item
    private struct PokemonListResponseItem: Decodable {
        let name: String
        let url: String
    }
    
    // List
    private struct PokemonListResponse: Decodable {
        let results: [PokemonListResponseItem]
    }
    
    // Detail
    private struct PokemonDetailResponse: Decodable {
        let id: Int
        let name: String
        let height: Double
        let weight: Double
    }
    
    // FavoritePokemon
    private struct FavoritePokemonResponse: Decodable {
        var id: Int
        var name: String
        var greeting: String
        var nickname: String
        var height: Double
        var weight: Double
        var imageUrl: String
    }
    
    
    // Generischer Typ, der Decodable sein muss
    // Asynchron: wir geben Betriebssystem die Kontrolle
    // wir rufen func auf und warten bis Antwort des Servers kommt
    // UI läuft in zwischen Zeit weiter
    // wenn antwort kommt, läuft Programmcode weiter
    
    // Alternativen: Clossures + Blocking UI
    
    private static func get<T: Decodable>(url: String) async throws -> T {
        // aus String soll URL Objekt werden
        // Grund: URLRequest hat URL als Argument
        
        // guard: wenn Fehler bei URL ist oder so: springt Compiler in Scope
        guard let parsedUrl = URL(string: url) else {
            throw ApiError.invalidUrl
        }
        
        // Request, Data und Response deklarieren
        let request = URLRequest(url: parsedUrl)
        let data: Data
        let response: URLResponse
        
        //
        do {
            // bei rechter Brille wird Tupel returnt
            // falls bei Methodenaufruf ein Error geschmissen werden kann, muss try und await verwendet werden
            // Daten fetchen
           (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            print(error)
            throw ApiError.connectionFailed
        }
        
        // nur weil request funktioniert hat, heißt das nicht, dass er auch auf dem Server funktioniert hat
        // deshalb muss man status code checken
    
        // wir betrachen objekt response als HTTPURLResponse
        // check ob HTTP code > 299
        if (response as! HTTPURLResponse).statusCode > 299 {
            throw ApiError.unexpectedStatusCode
        }
        
        // JSON-Objekt muss decodiert werden
        // muss failen, wenn wir anderes Format von Server bekommen
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            throw ApiError.invalidJSON
        }
    }

    // mit gefetchten Daten, erzeugen wir Liste mit PokemonListItems
    
    static func getPokemonList() async -> [PokeApi.PokemonListItem]? {
        do {
            // wir sagen der Get-Methode, was diese returnen soll -> Objekt von PokemonListResponse
            let response = try await get(url: "\(pokeAPIBaseURL)/pokemon?limit=151") as PokemonListResponse
            var pokemonList: [PokeApi.PokemonListItem] = []
            
            // im response Objekt (von der Klasse PokemonListResponse) befindet sich results member
            // wir ziehen von jedem pokemon Objekt die id und appenden es in die pokemonList
            for pokemon in response.results {
                let id = getPokemonIdFromURL(url: pokemon.url);
                pokemonList.append(
                    PokeApi.PokemonListItem(
                        id: id,
                        name: pokemon.name.capitalized,
                        imageUrl: getPokemonImageURL(id: id)
                    )
                )
            }
            return pokemonList
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getPokemonDetail(id: Int) async -> PokeApi.PokemonDetail?{
        do{
            let response = try await get(url: "\(pokeAPIBaseURL)/pokemon/\(id)") as PokemonDetailResponse
            let imageUrl = getPokemonImageURL(id: id)
            let pokemonDetail = PokeApi.PokemonDetail(id: id, name: response.name, height: response.height, weight: response.weight, imageUrl: imageUrl)
            return pokemonDetail
        }catch{
            print(error)
            return nil
        }
    }
    
    static func getFavoritePokemon(id: Int) async -> FavoritePokemon?{
        do{
            let response = try await get(url: "\(pokeAPIBaseURL)/pokemon/\(id)") as FavoritePokemonResponse
            let imageUrl = getPokemonImageURL(id: id)
            let favoritePokemon = FavoritePokemon(id: id, name: response.name, greeting: response.greeting, nickname: response.nickname, height: response.height, weight: response.weight, imageUrl: imageUrl)
            return favoritePokemon
        }catch{
            print(error)
            return nil
        }
    }

    private static func getPokemonIdFromURL(url: String) -> Int {
        return Int(url.split(separator: "/").last!) ?? -1
    }

    private static func getPokemonImageURL(id: Int) -> String {
        return "\(pokeAPIImageBaseURL)/\(id).png"
    }
}
