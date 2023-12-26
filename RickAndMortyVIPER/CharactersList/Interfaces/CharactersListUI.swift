//
//  CharactersListUI.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

protocol CharactersListUI: AnyObject {
    func update(characters: [CharacterCellViewModel])
}
