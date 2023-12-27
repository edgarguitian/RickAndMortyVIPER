//
//  EpisodesListInteractable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

protocol EpisodesListInteractable: AnyObject {
    func getEpisodesList() async -> EpisodesResponseEntity
}
