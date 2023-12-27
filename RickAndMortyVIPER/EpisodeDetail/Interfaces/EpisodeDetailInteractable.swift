//
//  EpisodeDetailInteractable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

protocol EpisodeDetailInteractable: AnyObject {
    func getDetailEpisode(withURL url: URL) async -> EpisodeDetailEntity
}
