//
//  DetailPokemonView.swift
//  PokemonIg
//
//  Created by Alumno on 25/08/25.
//


import SwiftUI

struct DetailPokemonView: View {
    let pokemon: Pokemon
    @State private var detail: DetailPokemon?
    var viewModel: PokemonViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            if let detail = detail {
                if let url = viewModel.getPokemonImageURL(for: pokemon) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("ID: \(detail.id)")
                Text("Height: \(detail.height)")
                Text("Weight: \(detail.weight)")
            } else {
                ProgressView("Loading details...")
            }
        }
        .padding()
        .onAppear {
            viewModel.loadDetails(for: pokemon) { loadedDetail in
                self.detail = loadedDetail
            }
        }
    }
}
