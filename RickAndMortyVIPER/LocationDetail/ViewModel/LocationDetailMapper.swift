//
//  LocationDetailMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct LocationDetailMapper {
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
    func map(entity: LocationDetailEntity, residents: [CharacterDetailViewModel]) -> LocationDetailViewModel {
        .init(name: entity.name,
              type: entity.type,
              dimension: entity.dimension,
              residents: map(residents: residents),
              locationURL: URL(string: entity.urlLocation))
    }
}
