# Pokédex App (SwiftUI + MVVM)

## What the app does
This iOS app fetches Pokémon data from the [PokéAPI](https://pokeapi.co/) and displays it in a two-level navigation interface:
 A List view (Pokédex) showing Pokémon names, IDs, and images.
 A Detail view showing additional details like height, weight, and sprite.

The app demonstrates clean SwiftUI design, robust error handling, and the MVVM architecture.

---

API
 List endpoint: `https://pokeapi.co/api/v2/pokemon?limit=20`
 Pokémon detail endpoint: `https://pokeapi.co/api/v2/pokemon/{id}/`

---

## Features
Two-level navigation (List → Detail)
Meaningful fields (title, image, ID, height, weight)
Loading indicators (`ProgressView`) for list and detail
Error handling (offline state, failed requests with friendly message)
MVVM architecture
Clean code: small views, single responsibility, consistent naming
Inline documentation with `// MARK:` sections
GitHub hygiene: README, commits, access


## Notes (Requirement mapping)
GET request: Implemented in `PokemonViewModel.loadPokemons()` and `loadDetails()`
API citation: PokéAPI link included above
2 levels navigation: `ContentView` → `DetailPokemonView`
Design: Hierarchical layout, spacing, readable typography
Error handling: Friendly messages + retry button
Feedback: Loading spinners in list and detail
MVVM: Models, ViewModel, Views are clearly separated
Clean code: Small functions, consistent naming, commented code
Documentation: Inline code comments explain design choices
GitHub hygiene: README, commits with meaningful messages


## How to run
1. Clone the repo:
   ```bash
[   git clone <https://github.com/IgnacioGzz/PokemonIg.git>
cd PokemonIg
