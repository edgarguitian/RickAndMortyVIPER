//
//  CharactersEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct CharactersEntity: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var urlCharacter: String
    var image: String

    enum CodingKeys: String, CodingKey {
        case urlCharacter = "url"
        case id, name, status, species, gender, image
    }

    func toDictionary() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary = [String: Any]()

        for child in mirror.children {
            if let key = child.label {
                dictionary[key] = child.value
            }
        }

        return dictionary
    }
}
