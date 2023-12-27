//
//  CharactersListInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class CharactersListInteractor: CharactersListInteractable {
    func getCharactersList(page: Int) async -> CharactersResponseEntity {
        let url = URL(string: "https://rickandmortyapi.com/api/character/?page=" + String(page))!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(CharactersResponseEntity.self, from: data)
    }
}
