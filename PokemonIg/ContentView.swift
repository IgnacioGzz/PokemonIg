//
//  ContentView 2.swift
//  PokemonIg
//
//  Created by Alumno on 25/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = PokemonViewModel()
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                if let errorMessage = errorMessage {
                    VStack {
                        Text(errorMessage)
                            .font(.headline)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button("Retry") {
                            loadData()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                } else if isLoading {
                    ProgressView("Loading Pokémon...")
                        .scaleEffect(1.5)
                        .padding()
                } else {
                    List(viewModel.pokemons) { pokemon in
                        NavigationLink {
                            DetailPokemonView(pokemon: pokemon, viewModel: viewModel)
                        } label: {
                            HStack(spacing: 15) {
                                if let url = viewModel.getPokemonImageURL(for: pokemon) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(pokemon.name.capitalized)
                                        .font(.headline)
                                    if let id = viewModel.getPokemonID(from: pokemon.url) {
                                        Text("ID: \(id)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .navigationTitle("Pokédex")
                }
            }
            .onAppear {
                loadData()
            }
        }
    }
    
    private func loadData() {
        isLoading = true
        errorMessage = nil
        viewModel.loadPokemons { error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = "Error loading Pokémon: \(error.localizedDescription)\nCheck your connection."
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
