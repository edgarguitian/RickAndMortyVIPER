//
//  EpisodeDetailMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct EpisodeDetailMapper {
    func map(entity: EpisodeDetailEntity) -> EpisodeDetailViewModel {
        .init(name: entity.name, airDate: entity.airDate, episode: entity.episode, urlEpisode: URL(string: entity.urlEpisode), characters: entity.characters)
    }
}
