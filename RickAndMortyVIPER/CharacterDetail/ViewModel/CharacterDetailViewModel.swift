//
//  CharacterDetailViewModel.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

struct CharacterDetailViewModel {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var origin: String
    var location: String
    var episode: [CharacterDetailEpisodeViewModel]
    var image: URL?
    var urlCharacter: URL?
}
