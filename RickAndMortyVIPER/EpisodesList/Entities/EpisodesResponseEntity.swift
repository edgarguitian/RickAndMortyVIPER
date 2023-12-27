//
//  EpisodesResponseEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct EpisodesResponseEntity: Decodable {
    let results: [EpisodesEntity]
}
