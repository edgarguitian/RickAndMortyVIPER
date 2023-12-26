//
//  CharacterMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct CharacterMapper {
    func map(entity: CharactersEntity) -> CharacterCellViewModel {
        CharacterCellViewModel(name: entity.name, status: entity.status, species: entity.species, characterURL: URL(string: entity.urlCharacter), imageURL: URL(string: entity.image))
    }
}
