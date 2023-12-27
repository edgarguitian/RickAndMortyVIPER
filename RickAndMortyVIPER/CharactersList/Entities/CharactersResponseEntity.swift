//
//  CharactersResponseEntity.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct CharactersResponseEntity: Decodable {
    let info: InfoEntity
    let results: [CharactersEntity]
}
