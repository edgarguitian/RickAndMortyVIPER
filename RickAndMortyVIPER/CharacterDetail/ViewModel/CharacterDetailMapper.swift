//
//  CharacterDetailMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct CharacterDetailMapper {
    func map(entity: CharacterDetailEntity) -> CharacterDetailViewModel {
        .init(id: entity.id, name: entity.name, status: entity.status,
              species: entity.species, gender: entity.gender,
              origin: entity.origin.name, location: entity.location.name,
              episode: entity.episode, image: URL(string: entity.image))
    }
}
