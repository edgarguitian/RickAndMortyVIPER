//
//  SceneDelegate.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var charactersListRouter = CharactersListRouter()
    var locationsListRouter = LocationsListRouter()
    var episodesListRouter = EpisodesListRouter()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        //charactersListRouter.showCharactersList(window: window)
        //locationsListRouter.showLocationsList(window: window)
        episodesListRouter.showEpisodesList(window: window)
    }

}

