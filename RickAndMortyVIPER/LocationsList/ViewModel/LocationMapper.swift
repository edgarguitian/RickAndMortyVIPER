//
//  LocationMapper.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct LocationMapper {
    func map(entity: LocationsEntity) -> LocationCellViewModel {
        LocationCellViewModel(name: entity.name,
                              type: entity.type,
                              dimension: entity.dimension,
                              locationURL: URL(string: entity.urlLocation))
    }
}
