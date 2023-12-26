//
//  CharacterDetailPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class CharacterDetailPresenter: CharacterDetailPresentable {
    private let characterDetailInteractor: CharacterDetailInteractable
    let characterURL: URL
    private let characterDetailMapper: CharacterDetailMapper
    weak var ui: CharacterDetailPresenterUI?
    
    init(characterDetailInteractor: CharacterDetailInteractable, characterURL: URL, characterDetailMapper: CharacterDetailMapper) {
        self.characterDetailInteractor = characterDetailInteractor
        self.characterURL = characterURL
        self.characterDetailMapper = characterDetailMapper
    }
    
    func onViewAppear() {
        Task {
            let model = await characterDetailInteractor.getDetailCharacter(withURL: characterURL)
            let viewModel = characterDetailMapper.map(entity: model)
            await MainActor.run {
                self.ui?.updateUI(viewModel: viewModel)
            }
        }
    }
    
    
}
