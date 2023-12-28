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
    private var currentPage: Int = 1
    private var numPages: Int = -1
    
    init(episodesListInteractor: EpisodesListInteractable,
         episodeMapper: EpisodeMapper,
         router: EpisodesListRouting) {
        self.episodesListInteractor = episodesListInteractor
        self.episodeMapper = episodeMapper
        self.router = router
    }
    
    func onViewAppear() {
        if numPages == -1 {
            loadEpisodes(page: currentPage)
        }
        
    }
    
    func loadEpisodes(page: Int) {
        if numPages == -1 || page <= numPages {
            Task {
                let episodesResult = await episodesListInteractor.getEpisodesList(page: page)
                numPages = episodesResult.info.pages
                let newEpisodes = episodesResult.results
                let newModels = newEpisodes.map(episodeMapper.map(entity:))
                episodesModels.append(contentsOf: newModels)
                ui?.update(episodes: episodesModels)
            }
        }
    }
    
    func onTapCell(atIndex: Int) {
        let episodeURL = models[atIndex].urlEpisode
        guard let episodeURL = URL(string: episodeURL) else {
            return
        }
        router.showDetailEpisode(withEpisodeURL: episodeURL)
    }
    
    func loadMoreData() {
        currentPage += 1
        loadEpisodes(page: currentPage)
    }
}
