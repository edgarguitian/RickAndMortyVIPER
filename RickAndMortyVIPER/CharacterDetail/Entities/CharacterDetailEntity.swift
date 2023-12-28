//
//  CharacterDetailEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

struct CharacterDetailEntity: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var origin: LocationCharacter
    var location: LocationCharacter
    var episode: [String]
    var image: String
    var urlCharacter: String

    enum CodingKeys: String, CodingKey {
        case urlCharacter = "url"
        case id, name, status, species, gender, origin, location, episode, image
    }
}

struct LocationCharacter: Decodable {
    var name: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case name, url
    }
}
