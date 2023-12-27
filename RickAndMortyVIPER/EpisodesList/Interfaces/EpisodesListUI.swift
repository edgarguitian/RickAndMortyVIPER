//
//  EpisodesListUI.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

protocol EpisodesListUI: AnyObject {
    func update(episodes: [EpisodeCellViewModel])
}
