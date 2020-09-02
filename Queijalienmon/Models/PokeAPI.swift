import Foundation
import UIKit

class PokeAPI {
    
    func get(name: String){
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {data, response, error in
            do {
                let decoder = JSONDecoder()
                let pokemon = try? decoder.decode(Pokemon.self, from: data!)
                
                guard let pokeData = pokemon else {
                    //Adicionar um handler de erro
                    return
                }
                
                self.getImage(url: pokeData.sprites.frontDefault)
                
            } catch {
                print("erro")
            }
        }
        task.resume()
    }
    
    func getImage(url: String){
        
    }
    
}
