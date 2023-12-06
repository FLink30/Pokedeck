import Foundation

class HttpApi{

    func getPokemonList(){
        // Wir brauchen die URL
        let parsedUrl =  URL(string: "https://pokeapi.co/api/v2/pokemon")
        parsedUrl
        // Daraus wird ein Request-Object - kann nil sein
        let request = URLRequest(parsedUrl!)
        URLSession.shared.data(for:URLRequest)
    }
    
}

// Instanz von HttpAPi
let api = HttpApi()

api.getPokemonList()




