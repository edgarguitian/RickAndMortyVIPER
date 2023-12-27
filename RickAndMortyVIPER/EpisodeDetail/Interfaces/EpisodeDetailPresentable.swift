//
//  EpisodeDetailPresentable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

protocol EpisodeDetailPresentable: AnyObject {
    var ui: EpisodeDetailPresenterUI? { get }
    var episodeURL: URL { get }
    var episodeModel: EpisodeDetailViewModel? { get }
    func onViewAppear()
    func onTapCell(atIndex: Int)
}
