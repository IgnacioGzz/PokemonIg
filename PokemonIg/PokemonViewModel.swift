//
//  PokemonViewModel.swift
//  PokemonIg
//
//  Created by Alumno on 25/08/25.
//

import Foundation

@Observable
class PokemonViewModel {
    var pokemons: [Pokemon] = []
    var nextPage: String? = "https://pokeapi.co/api/v2/pokemon?limit=20"
    
    // MARK: - Load Pokémon list
    func loadPokemons(completion: @escaping (Error?) -> Void) {
        guard let url = nextPage else {
            completion(nil)
            return
        }
        
        Bundle.main.fetchData(
            url: url,
            model: PokemonPage.self
        ) { page in
            DispatchQueue.main.async {
                self.pokemons.append(contentsOf: page.results)
                self.nextPage = page.next
                completion(nil)
            }
        } failure: { error in
            completion(error)
        }
    }
    
    // MARK: - Load details for one Pokémon
    func loadDetails(for pokemon: Pokemon, completion: @escaping (DetailPokemon?) -> Void) {
        Bundle.main.fetchData(
            url: pokemon.url,
            model: DetailPokemon.self
        ) { detail in
            DispatchQueue.main.async {
                completion(detail)
            }
        } failure: { error in
            print("Error fetching details: \(error)")
            completion(nil)
        }
    }
    
    // MARK: - Utility functions
    func getPokemonID(from url: String) -> String? {
        let parts = url.split(separator: "/").compactMap { Int($0) }
        return parts.last.map { String($0) }
    }
    
    func getPokemonImageURL(for pokemon: Pokemon) -> URL? {
        guard let id = getPokemonID(from: pokemon.url) else { return nil }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}
