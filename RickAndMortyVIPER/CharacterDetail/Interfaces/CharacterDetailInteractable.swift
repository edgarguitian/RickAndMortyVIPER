//
//  CharacterDetailInteractable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

protocol CharacterDetailInteractable: AnyObject {
    func getDetailCharacter(withURL url: URL) async -> CharacterDetailEntity
}
