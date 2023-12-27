//
//  LocationDetailRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

class LocationDetailRouter: LocationDetailRouting {

    func showDetail(fromViewController: UIViewController, withLocationURL locationURL: URL) {
        let interactor = LocationDetailInteractor()
        let presenter = LocationDetailPresenter(locationDetailInteractor: interactor, locationURL: locationURL, locationDetailMapper: LocationDetailMapper())
        let view = LocationDetailView(presenter: presenter)
        presenter.ui = view
        
        fromViewController.present(view, animated: true)
    }
    
    
}
