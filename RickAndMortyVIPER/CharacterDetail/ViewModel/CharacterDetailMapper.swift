//
//  CharacterDetailMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct CharacterDetailMapper {
    func map(episodes: [EpisodeDetailViewModel]) -> [CharacterDetailEpisodeViewModel] {
        var result: [CharacterDetailEpisodeViewModel] = []
        for episode in episodes {
            let characterDetailEpisodeViewModel = CharacterDetailEpisodeViewModel(name: episode.name, episode: episode.episode, urlEpisode: episode.urlEpisode)
            result.append(characterDetailEpisodeViewModel)
        }
        return result
        
    }
    func map(entity: CharacterDetailEntity, episodes: [EpisodeDetailViewModel]) -> CharacterDetailViewModel {
        .init(id: entity.id, name: entity.name, status: entity.status,
              species: entity.species, gender: entity.gender,
              origin: entity.origin.name, location: entity.location.name,
              episode: map(episodes: episodes), image: URL(string: entity.image), urlCharacter: URL(string: entity.urlCharacter))
    }
}
