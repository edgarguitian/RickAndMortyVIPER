//
//  EpisodesListPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class EpisodesListPresenter: EpisodesListPresentable {
    weak var ui: EpisodesListUI?
    private let episodesListInteractor: EpisodesListInteractable
    var episodesModels: [EpisodeCellViewModel] = []
    private var models: [EpisodesEntity] = []
    private let episodeMapper: EpisodeMapper
    private let router: EpisodesListRouting
    
    init(episodesListInteractor: EpisodesListInteractable,
         episodeMapper: EpisodeMapper,
         router: EpisodesListRouting) {
        self.episodesListInteractor = episodesListInteractor
        self.episodeMapper = episodeMapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            models = await episodesListInteractor.getEpisodesList().results
            episodesModels = models.map(episodeMapper.map(entity:))
            ui?.update(episodes: episodesModels)
        }
        
    }
    
    func onTapCell(atIndex: Int) {
        let episodeURL = models[atIndex].urlEpisode
        guard let episodeURL = URL(string: episodeURL) else {
            return
        }
        router.showDetailEpisode(withEpisodeURL: episodeURL)
    }
}
