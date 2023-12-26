//
//  CharactersListRouting.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

protocol CharactersListRouting: AnyObject {
    var detailRouter: CharacterDetailRouting? { get }
    var charactersListView: CharactersListView? { get }
    
    func showCharactersList(window: UIWindow?)
    func showDetailCharacter(withCharacterURL characterURL: URL)
}
