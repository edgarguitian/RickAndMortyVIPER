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
        
        let charactersListView = charactersListRouter.createCharactersList()
        
        let locationsListView = locationsListRouter.createLocationsList()
        let episodesListView = episodesListRouter.createEpisodesList()
        
        let tabBarController = UITabBarController()
        
        let charactersTab = UINavigationController(rootViewController: charactersListView)
        charactersTab.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.3.fill"), tag: 0)
        
        let locationsTab = UINavigationController(rootViewController: locationsListView)
        locationsTab.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "location.fill"), tag: 1)
        
        let episodesTab = UINavigationController(rootViewController: episodesListView)
        episodesTab.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv.fill"), tag: 2)
        
        tabBarController.viewControllers = [charactersTab, locationsTab, episodesTab]
        
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
    }
    
}

