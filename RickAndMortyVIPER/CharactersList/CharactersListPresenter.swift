//
//  CharactersListPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class CharactersListPresenter: CharactersListPresentable {
    
    weak var ui: CharactersListUI?
    private let charactersListInteractor: CharactersListInteractable
    var charactersModels: [CharacterCellViewModel] = []
    private var models: [CharactersEntity] = []
    private let characterMapper: CharacterMapper
    private let router: CharactersListRouting
    
    init(charactersListInteractor: CharactersListInteractable,
         characterMapper: CharacterMapper,
         router: CharactersListRouting) {
        self.charactersListInteractor = charactersListInteractor
        self.characterMapper = characterMapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            models = await charactersListInteractor.getCharactersList().results
            charactersModels = models.map(characterMapper.map(entity:))
            ui?.update(characters: charactersModels)
        }
    }
    
    func onTapCell(atIndex: Int) {
        let characterURL = models[atIndex].urlCharacter
        guard let characterURL = URL(string: characterURL) else {
            return
        }
        router.showDetailCharacter(withCharacterURL: characterURL)
    }
}
