//
//  CharactersListInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class CharactersListInteractor: CharactersListInteractable {
    func getCharactersList(page: Int) async -> CharactersResponseEntity {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=" + String(page)) else {
            fatalError("Error en la url de characters")
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(CharactersResponseEntity.self, from: data)
            return decodedData
        } catch {
            fatalError("Error en el decode de characters")
        }

    }
}
