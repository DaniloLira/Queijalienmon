import Foundation
import UIKit

class PokeAPI {
    
    static let shared = PokeAPI()

    static func get(name: String){
        let lowerCaseName = name.lowercased()
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(lowerCaseName)")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) {data, response, error in
            do {
                let decoder = JSONDecoder()
                let pokemon = try? decoder.decode(Pokemon.self, from: data!)
                
                guard let pokeData = pokemon else {
                    //Adicionar um handler de erro
                    return
                }
                
                PokeAPI.getImage(url: pokeData.sprites.frontDefault)
            }
        }
        task.resume()
    }
    
    static private func getImage(url: String){
        let url = URL(string: url)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {data, response, error in
            PokeResult.shared.image = UIImage(data: data!)!
        }
        task.resume()
    }
    
}
