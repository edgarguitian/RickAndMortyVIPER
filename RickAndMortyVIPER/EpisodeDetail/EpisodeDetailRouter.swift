//
//  EpisodeDetailRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

class EpisodeDetailRouter: EpisodeDetailRouting {

    func showDetail(fromViewController: UIViewController, withEpisodeURL EpisodeURL: URL) {
        let interactor = EpisodeDetailInteractor()
        let presenter = EpisodeDetailPresenter(episodeDetailInteractor: interactor, episodeURL: EpisodeURL, episodeDetailMapper: EpisodeDetailMapper())
        let view = EpisodeDetailView(presenter: presenter)
        presenter.ui = view
        
        fromViewController.present(view, animated: true)
    }
    
    
}
