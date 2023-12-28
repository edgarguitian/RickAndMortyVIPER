//
//  LocationsEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct LocationsEntity: Decodable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var urlLocation: String

    enum CodingKeys: String, CodingKey {
        case urlLocation = "url"
        case id, name, type, dimension
    }
}
