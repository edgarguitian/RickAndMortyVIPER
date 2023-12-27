//
//  CharacterDetailPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class CharacterDetailPresenter: CharacterDetailPresentable {
    private let characterDetailInteractor: CharacterDetailInteractable
    private let episodeDetailInteractor: EpisodeDetailInteractable

    let characterURL: URL
    private let characterDetailMapper: CharacterDetailMapper
    private let episodeDetailMapper: EpisodeDetailMapper
    var characterModel: CharacterDetailViewModel?
    private var infoEpisodes: [EpisodeDetailViewModel] = []
    weak var ui: CharacterDetailPresenterUI?
    private let router: CharacterDetailRouting

    init(characterDetailInteractor: CharacterDetailInteractable,
         episodeDetailInteractor: EpisodeDetailInteractor,
         characterURL: URL,
         characterDetailMapper: CharacterDetailMapper,
         episodeDetailMapper: EpisodeDetailMapper,
         router: CharacterDetailRouting) {
        self.characterDetailInteractor = characterDetailInteractor
        self.episodeDetailInteractor = episodeDetailInteractor
        self.characterURL = characterURL
        self.characterDetailMapper = characterDetailMapper
        self.episodeDetailMapper = episodeDetailMapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            let model = await characterDetailInteractor.getDetailCharacter(withURL: characterURL)
            for episodeItem in 0..<model.episode.count {
                let episode = await episodeDetailInteractor.getDetailEpisode(withURL: URL(string: model.episode[episodeItem])!)
                let episodeModel = episodeDetailMapper.map(entity: episode)
                infoEpisodes.append(episodeModel)
            }
            characterModel = characterDetailMapper.map(entity: model, episodes: infoEpisodes)
            await MainActor.run {
                self.ui?.updateUI(viewModel: characterModel!)
            }
        }
    }
    
    func onTapCell(atIndex: Int) {
        let episodeURL = infoEpisodes[atIndex].urlEpisode
        guard let episodeURL = episodeURL else {
            return
        }
        router.showDetailEpisode(withEpisodeURL: episodeURL)
    }
    
    
}
