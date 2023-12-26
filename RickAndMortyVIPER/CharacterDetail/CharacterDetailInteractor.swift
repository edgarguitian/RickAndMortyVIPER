//
//  CharacterDetailInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class CharacterDetailInteractor: CharacterDetailInteractable {
    func getDetailCharacter(withURL url: URL) async -> CharacterDetailEntity {
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(CharacterDetailEntity.self, from: data)

    }

}
