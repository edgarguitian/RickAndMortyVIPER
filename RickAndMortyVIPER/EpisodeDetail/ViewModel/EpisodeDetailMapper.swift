//
//  EpisodeDetailMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct EpisodeDetailMapper {
    func map(residents: [CharacterDetailViewModel]) -> [LocationDetailResidentViewModel] {
        var result: [LocationDetailResidentViewModel] = []
        for resident in residents {
            let locationDetailResidentViewModel = LocationDetailResidentViewModel(name: resident.name,
                                                                                  image: resident.image,
                                                                                  urlResident: resident.urlCharacter)
            result.append(locationDetailResidentViewModel)
        }
        return result

    }

    func map(entity: EpisodeDetailEntity, characters: [CharacterDetailViewModel]) -> EpisodeDetailViewModel {
        .init(name: entity.name,
              airDate: entity.airDate,
              episode: entity.episode,
              urlEpisode: URL(string: entity.urlEpisode),
              characters: map(residents: characters))
    }
}
