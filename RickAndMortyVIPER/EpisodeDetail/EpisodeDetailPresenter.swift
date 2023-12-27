//
//  EpisodeDetailPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class EpisodeDetailPresenter: EpisodeDetailPresentable {
    private let episodeDetailInteractor: EpisodeDetailInteractable
    let episodeURL: URL
    private let episodeDetailMapper: EpisodeDetailMapper
    var episodeModel: EpisodeDetailViewModel?
    
    weak var ui: EpisodeDetailPresenterUI?
    
    init(episodeDetailInteractor: EpisodeDetailInteractable, episodeURL: URL, episodeDetailMapper: EpisodeDetailMapper) {
        self.episodeDetailInteractor = episodeDetailInteractor
        self.episodeURL = episodeURL
        self.episodeDetailMapper = episodeDetailMapper
    }
    
    func onViewAppear() {
        Task {
            let model = await episodeDetailInteractor.getDetailEpisode(withURL: episodeURL)
            episodeModel = episodeDetailMapper.map(entity: model)
            await MainActor.run {
                self.ui?.updateUI(viewModel: episodeModel!)
            }
        }
    }
}
