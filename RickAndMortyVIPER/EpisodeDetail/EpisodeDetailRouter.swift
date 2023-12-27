//
//  EpisodeDetailRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

class EpisodeDetailRouter: EpisodeDetailRouting {
    var episodeDetailView: EpisodeDetailView?

    func showDetail(fromViewController: UIViewController, withEpisodeURL episodeURL: URL) {
        let interactor = EpisodeDetailInteractor()
        let interactorCharacter = CharacterDetailInteractor()

        let presenter = EpisodeDetailPresenter(episodeDetailInteractor: interactor,
                                               characterDetailInteractor: interactorCharacter,
                                               episodeURL: episodeURL,
                                               episodeDetailMapper: EpisodeDetailMapper(),
                                               characterDetailMapper: CharacterDetailMapper(),
                                               router: self)
        episodeDetailView = EpisodeDetailView(presenter: presenter)
        guard let episodeDetailView = episodeDetailView else {
            return
        }
        
        episodeDetailView.hidesBottomBarWhenPushed = true
        presenter.ui = episodeDetailView
        if let navigationController = fromViewController.navigationController {
            navigationController.pushViewController(episodeDetailView, animated: true)
        } else {
            fromViewController.present(episodeDetailView, animated: true)
        }
    }
    
    
    func showDetailCharacters(withCharacterURL characterURL: URL) {
        guard let episodeDetailView = episodeDetailView else {
            return
        }
        
        CharacterDetailRouter().showDetail(fromViewController: episodeDetailView, withCharacterURL: characterURL)
    }
    
}
