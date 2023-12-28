//
//  LocationDetailEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct LocationDetailEntity: Decodable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var urlLocation: String
    var residents: [String]

    enum CodingKeys: String, CodingKey {
        case urlLocation = "url"
        case id, name, type, dimension, residents
    }
}
