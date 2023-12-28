//
//  InfoEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct InfoEntity: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?

    enum CodingKeys: String, CodingKey {
        case count, pages, next, prev
    }
}
