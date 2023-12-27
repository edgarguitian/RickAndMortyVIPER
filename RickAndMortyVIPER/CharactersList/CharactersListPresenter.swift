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
    let charactersStatus: [String] = ["alive", "dead", "unknown"]
    let charactersGender: [String] = ["female", "male", "genderless", "unknown"]
    var selectedStatusIndex: Int?
    var selectedGenderIndex: Int?
    private var currentPage: Int = 1
    private var numPages: Int = -1
    
    init(charactersListInteractor: CharactersListInteractable,
         characterMapper: CharacterMapper,
         router: CharactersListRouting) {
        self.charactersListInteractor = charactersListInteractor
        self.characterMapper = characterMapper
        self.router = router
    }
    
    func onViewAppear() {
        if numPages == -1 {
            loadCharacters(page: currentPage)
        }
    }
    
    private func loadCharacters(page: Int) {
        if numPages == -1 || page <= numPages {
            Task {
                let charactersResult = await charactersListInteractor.getCharactersList(page: page)
                numPages = charactersResult.info.pages
                let newCharacters = charactersResult.results
                let newModels = newCharacters.map(characterMapper.map(entity:))
                charactersModels.append(contentsOf: newModels)
                filteredCharacters = charactersModels
                ui?.update(characters: charactersModels)
            }
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
    
    func filterCharacters() {
        let hasStatusFilter = selectedStatusIndex != nil && selectedStatusIndex! > -1
        let hasGenderFilter = selectedGenderIndex != nil && selectedGenderIndex! > -1
        
        filteredCharacters = charactersModels.filter { result in
            let matchesStatus = !hasStatusFilter || result.status.lowercased() == charactersStatus[selectedStatusIndex!]
            let matchesGender = !hasGenderFilter || result.gender.lowercased() == charactersGender[selectedGenderIndex!]
            
            return matchesStatus && matchesGender
        }
        ui?.update(characters: filteredCharacters)
        
    }
    
    func handleFilterButtonTap() {
        router.showFilterView()
    }
    
    func resetFilters() {
        selectedStatusIndex = nil
        selectedGenderIndex = nil
        filteredCharacters = charactersModels
        ui?.update(characters: filteredCharacters)
        
    }
    
    func loadMoreData() {
        currentPage += 1
        loadCharacters(page: currentPage)
    }
}
