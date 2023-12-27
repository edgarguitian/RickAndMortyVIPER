//
//  EpisodeDetailPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class EpisodeDetailPresenter: EpisodeDetailPresentable {
    private let episodeDetailInteractor: EpisodeDetailInteractable
    private let characterDetailInteractor: CharacterDetailInteractable

    let episodeURL: URL
    private let episodeDetailMapper: EpisodeDetailMapper
    var episodeModel: EpisodeDetailViewModel?
    private let characterDetailMapper: CharacterDetailMapper
    private let router: EpisodeDetailRouting
    private var infoCharacters: [CharacterDetailViewModel] = []
    weak var ui: EpisodeDetailPresenterUI?
    
    init(episodeDetailInteractor: EpisodeDetailInteractable,
         characterDetailInteractor: CharacterDetailInteractable,
         episodeURL: URL, episodeDetailMapper: EpisodeDetailMapper,
         characterDetailMapper: CharacterDetailMapper,
         router: EpisodeDetailRouting) {
        self.episodeDetailInteractor = episodeDetailInteractor
        self.characterDetailInteractor = characterDetailInteractor
        self.episodeURL = episodeURL
        self.episodeDetailMapper = episodeDetailMapper
        self.characterDetailMapper = characterDetailMapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            let model = await episodeDetailInteractor.getDetailEpisode(withURL: episodeURL)
            for characterItem in 0..<model.characters.count {
                let character = await characterDetailInteractor.getDetailCharacter(withURL: URL(string: model.characters[characterItem])!)
                let characterModel = characterDetailMapper.map(entity: character, episodes: [])
                infoCharacters.append(characterModel)
            }
            episodeModel = episodeDetailMapper.map(entity: model, characters: infoCharacters)
            await MainActor.run {
                self.ui?.updateUI(viewModel: episodeModel!)
            }
        }
    }
    
    func onTapCell(atIndex: Int) {
        let characterURL = infoCharacters[atIndex].urlCharacter
        guard let characterURL = characterURL else {
            return
        }
        router.showDetailCharacters(withCharacterURL: characterURL)
    }
}
