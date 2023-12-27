//
//  EpisodesListRouting.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

protocol EpisodesListRouting: AnyObject {
    var detailRouter: EpisodeDetailRouting? { get }
    var episodesListView: EpisodesListView? { get }
    
    func createEpisodesList() -> EpisodesListView
    func showDetailEpisode(withEpisodeURL episodeURL: URL)
}
