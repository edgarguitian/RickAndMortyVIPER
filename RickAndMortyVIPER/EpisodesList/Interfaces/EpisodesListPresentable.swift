//
//  EpisodesListPresentable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

protocol EpisodesListPresentable: AnyObject {
    var episodeListUI: EpisodesListUI? { get }
    var episodesModels: [EpisodeCellViewModel] { get }
    func onViewAppear()
    func loadMoreData()
    func onTapCell(atIndex: Int)
}
