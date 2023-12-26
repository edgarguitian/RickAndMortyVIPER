//
//  CharacterDetailRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

class CharacterDetailRouter: CharacterDetailRouting {

    func showDetail(fromViewController: UIViewController, withCharacterURL characterURL: URL) {
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter(characterDetailInteractor: interactor,
                                                 characterURL: characterURL,
                                                 characterDetailMapper: CharacterDetailMapper())
        let view = CharacterDetailView(presenter: presenter)
        presenter.ui = view
        
        fromViewController.present(view, animated: true)
    }
    
    
}
