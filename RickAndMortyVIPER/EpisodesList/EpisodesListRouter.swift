//
//  EpisodesListRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

class EpisodesListRouter: EpisodesListRouting {
    var detailRouter: EpisodeDetailRouting?
    var episodesListView: EpisodesListView?
    
    func showEpisodesList(window: UIWindow?) {
        let interactor = EpisodesListInteractor()
        let presenter = EpisodesListPresenter(episodesListInteractor: interactor, episodeMapper: EpisodeMapper(), router: self)
        episodesListView = EpisodesListView(presenter: presenter)
        presenter.ui = episodesListView
        detailRouter = EpisodeDetailRouter()
        window?.rootViewController = episodesListView
        window?.makeKeyAndVisible()
    }
    
    func showDetailEpisode(withEpisodeURL episodeURL: URL) {
        guard let episodesListView = episodesListView else {
            return
        }
        
        detailRouter?.showDetail(fromViewController: episodesListView, withEpisodeURL: episodeURL)
    }
}
