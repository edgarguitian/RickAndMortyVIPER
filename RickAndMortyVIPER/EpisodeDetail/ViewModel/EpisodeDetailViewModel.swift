//
//  EpisodeDetailViewModel.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

struct EpisodeDetailViewModel {
    var name: String
    var airDate: String
    var episode: String
    var urlEpisode: URL?
    var characters: [LocationDetailResidentViewModel]
}
