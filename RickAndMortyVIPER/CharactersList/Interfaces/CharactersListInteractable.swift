//
//  CharactersListInteractable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

protocol CharactersListInteractable: AnyObject {
    func getCharactersList() async -> CharactersResponseEntity
}
