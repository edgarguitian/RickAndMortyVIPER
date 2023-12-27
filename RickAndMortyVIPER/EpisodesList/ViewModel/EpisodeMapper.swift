//
//  EpisodeMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct EpisodeMapper {
    func map(entity: EpisodesEntity) -> EpisodeCellViewModel {
        EpisodeCellViewModel(name: entity.name, episode: entity.episode, urlEpisode: URL(string: entity.urlEpisode))
    }
}
