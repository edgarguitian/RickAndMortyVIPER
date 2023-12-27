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
    var filteredCharacters: [CharacterCellViewModel] = []
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
            filteredCharacters = charactersModels
            ui?.update(characters: charactersModels)
        }
    }
    
    func onTapCell(atIndex: Int) {
        let characterURL = filteredCharacters[atIndex].characterURL
        guard let characterURL = characterURL else {
            return
        }
        router.showDetailCharacter(withCharacterURL: characterURL)
    }
    
    func updateFilteredCharacters(_ characters: [CharacterCellViewModel]) {
        filteredCharacters = characters
        ui?.update(characters: filteredCharacters)
    }
}
