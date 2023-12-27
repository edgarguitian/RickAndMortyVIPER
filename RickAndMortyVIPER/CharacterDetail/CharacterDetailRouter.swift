//
//  CharacterDetailRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

class CharacterDetailRouter: CharacterDetailRouting {
    
    var characterDetailView: CharacterDetailView?
    
    func showDetail(fromViewController: UIViewController, withCharacterURL characterURL: URL) {
        let interactorCharacter = CharacterDetailInteractor()
        let interactorEpisodes = EpisodeDetailInteractor()
        let presenter = CharacterDetailPresenter(characterDetailInteractor: interactorCharacter,
                                                 episodeDetailInteractor: interactorEpisodes,
                                                 characterURL: characterURL,
                                                 characterDetailMapper: CharacterDetailMapper(),
                                                 episodeDetailMapper: EpisodeDetailMapper(),
                                                 router: self)
        characterDetailView = CharacterDetailView(presenter: presenter)
        guard let characterDetailView = characterDetailView else {
            return
        }
        characterDetailView.hidesBottomBarWhenPushed = true
        presenter.ui = characterDetailView
        if let navigationController = fromViewController.navigationController {
            navigationController.pushViewController(characterDetailView, animated: true)
        } else {
            fromViewController.present(characterDetailView, animated: true)
        }
    }
    
    func showDetailEpisode(withEpisodeURL episodeURL: URL) {
        guard let characterDetailView = characterDetailView else {
            return
        }
        
        EpisodeDetailRouter().showDetail(fromViewController: characterDetailView, withEpisodeURL: episodeURL)
        
    }
    
    
}
