//
//  EpisodesEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct EpisodesEntity: Decodable {
    var id: Int
    var name: String
    var episode: String
    var urlEpisode: String

    enum CodingKeys: String, CodingKey {
        case urlEpisode = "url"
        case id, name, episode
    }
}
