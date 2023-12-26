//
//  LocationsResponseEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct LocationsResponseEntity: Decodable {
    let results: [LocationsEntity]
}
