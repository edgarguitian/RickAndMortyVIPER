//
//  CharactersListPresentable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

protocol CharactersListPresentable: AnyObject {
    var ui: CharactersListUI? { get }
    var charactersModels: [CharacterCellViewModel] { get }
    var filteredCharacters: [CharacterCellViewModel] { get set }
    func onViewAppear()
    func onTapCell(atIndex: Int)
    func updateFilteredCharacters(_ characters: [CharacterCellViewModel])
    func handleFilterButtonTap()
    func resetFilters()
    func filterCharacters()
    func loadMoreData()
    var charactersStatus: [String] { get }
    var charactersGender: [String] { get }
    var selectedStatusIndex: Int? { get set }
    var selectedGenderIndex: Int? { get set }
}
