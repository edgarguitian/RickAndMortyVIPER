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
    func onViewAppear()
    func onTapCell(atIndex: Int)
}
