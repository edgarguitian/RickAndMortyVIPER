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
    var presenter: CharactersListPresenter?
    
    func createCharactersList() -> CharactersListView {
        let interactor = CharactersListInteractor()
        presenter = CharactersListPresenter(charactersListInteractor: interactor, characterMapper: CharacterMapper(), router: self)
        
        guard let presenter = presenter else {
            fatalError()
        }
        
        charactersListView = CharactersListView(presenter: presenter)
        presenter.ui = charactersListView
        detailRouter = CharacterDetailRouter()
        guard let charactersListView = charactersListView else {
            fatalError()
        }
        
        return charactersListView
    }
    
    func showDetailCharacter(withCharacterURL characterURL: URL) {
        guard let charactersListView = charactersListView else {
            return
        }
        
        detailRouter?.showDetail(fromViewController: charactersListView, withCharacterURL: characterURL)
    }
    
    func showFilterView() {
        guard let charactersListView = charactersListView else {
            return
        }
        
        guard let presenter = presenter else {
            return
        }
        
        charactersListView.present(FilterView(presenter: presenter), animated: true)
    }
}
