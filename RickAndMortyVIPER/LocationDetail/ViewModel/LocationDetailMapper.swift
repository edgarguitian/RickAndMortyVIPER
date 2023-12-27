//
//  LocationDetailMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct LocationDetailMapper {
    func map(entity: LocationDetailEntity) -> LocationDetailViewModel {
        .init(name: entity.name, type: entity.type, dimension: entity.dimension, residents: entity.residents, locationURL: URL(string: entity.urlLocation))
    }
}
