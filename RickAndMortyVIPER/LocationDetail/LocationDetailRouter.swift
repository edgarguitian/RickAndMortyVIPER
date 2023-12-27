//
//  LocationDetailRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

class LocationDetailRouter: LocationDetailRouting {
    
    var locationDetailView: LocationDetailView?


    func showDetail(fromViewController: UIViewController, withLocationURL locationURL: URL) {
        let interactor = LocationDetailInteractor()
        let interactorCharacter = CharacterDetailInteractor()

        let presenter = LocationDetailPresenter(locationDetailInteractor: interactor,
                                                characterDetailInteractor: interactorCharacter,
                                                locationURL: locationURL,
                                                locationDetailMapper: LocationDetailMapper(),
                                                characterDetailMapper: CharacterDetailMapper(),
                                                router: self)
        locationDetailView = LocationDetailView(presenter: presenter)
        guard let locationDetailView = locationDetailView else {
            return
        }
        locationDetailView.hidesBottomBarWhenPushed = true
        presenter.ui = locationDetailView
        if let navigationController = fromViewController.navigationController {
            navigationController.pushViewController(locationDetailView, animated: true)
        } else {
            fromViewController.present(locationDetailView, animated: true)
        }
    }
    
    func showDetailResident(withResidentURL residentURL: URL) {
        guard let locationDetailView = locationDetailView else {
            return
        }
        
        CharacterDetailRouter().showDetail(fromViewController: locationDetailView, withCharacterURL: residentURL)
    }
    
    
    
    
}
