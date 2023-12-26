//
//  CharactersListRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

class CharactersListRouter: CharactersListRouting {
    var detailRouter: CharacterDetailRouting?
    var charactersListView: CharactersListView?
    
    func showCharactersList(window: UIWindow?) {
        let interactor = CharactersListInteractor()
        let presenter = CharactersListPresenter(charactersListInteractor: interactor, characterMapper: CharacterMapper(), router: self)
        charactersListView = CharactersListView(presenter: presenter)
        presenter.ui = charactersListView
        detailRouter = CharacterDetailRouter()
        window?.rootViewController = charactersListView
        window?.makeKeyAndVisible()
    }
    
    func showDetailCharacter(withCharacterURL characterURL: URL) {
        guard let charactersListView = charactersListView else {
            return
        }
        
        detailRouter?.showDetail(fromViewController: charactersListView, withCharacterURL: characterURL)
    }
}
