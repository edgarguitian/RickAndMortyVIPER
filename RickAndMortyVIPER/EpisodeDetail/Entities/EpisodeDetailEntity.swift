//
//  EpisodeDetailEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct EpisodeDetailEntity: Decodable {
    var id: Int
    var name: String
    var airDate: String
    var episode: String
    var urlEpisode: String
    var characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case urlEpisode = "url"
        case airDate = "air_date"
        case id, name, episode, characters
    }
}
