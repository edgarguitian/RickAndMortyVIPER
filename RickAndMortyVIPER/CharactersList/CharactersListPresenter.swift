//
//  CharactersListPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class CharactersListPresenter: CharactersListPresentable {

    weak var charactersListUI: CharactersListUI?
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
            var allCharacters = CoreDataManager.shared.getAllCharacters(page: page)
            if allCharacters.count > 0 {
                allCharacters = allCharacters.sorted(by: { $0.id < $1.id })

                let newCharacters = allCharacters.map {
                    CharactersEntity(id: Int($0.id),
                                     name: $0.name!,
                                     status: $0.status!,
                                     species: $0.species!,
                                     gender: $0.gender!,
                                     urlCharacter: $0.urlCharacter!,
                                     image: $0.image!)
                }
                let newModels = newCharacters.map(characterMapper.map(entity:))
                numPages = Int(allCharacters[allCharacters.count - 1].numPages)
                charactersModels.append(contentsOf: newModels)
                filteredCharacters = charactersModels
                charactersListUI?.update(characters: charactersModels)
            } else {
                Task {
                    let charactersResult = await charactersListInteractor.getCharactersList(page: page)
                    numPages = charactersResult.info.pages
                    let newCharacters = charactersResult.results
                    CoreDataManager.shared.insertCharacters(entities: newCharacters, page: page, numPages: numPages)

                    let newModels = newCharacters.map(characterMapper.map(entity:))
                    charactersModels.append(contentsOf: newModels)
                    filteredCharacters = charactersModels
                    charactersListUI?.update(characters: charactersModels)
                }
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
        charactersListUI?.update(characters: filteredCharacters)
    }

    func filterCharacters() {
        let hasStatusFilter = selectedStatusIndex != nil && selectedStatusIndex! > -1
        let hasGenderFilter = selectedGenderIndex != nil && selectedGenderIndex! > -1

        filteredCharacters = charactersModels.filter { result in
            let matchesStatus = !hasStatusFilter || result.status.lowercased() == charactersStatus[selectedStatusIndex!]
            let matchesGender = !hasGenderFilter || result.gender.lowercased() == charactersGender[selectedGenderIndex!]

            return matchesStatus && matchesGender
        }
        charactersListUI?.update(characters: filteredCharacters)

    }

    func handleFilterButtonTap() {
        router.showFilterView()
    }

    func resetFilters() {
        selectedStatusIndex = nil
        selectedGenderIndex = nil
        filteredCharacters = charactersModels
        charactersListUI?.update(characters: filteredCharacters)

    }

    func loadMoreData() {
        currentPage += 1
        loadCharacters(page: currentPage)
    }
}
