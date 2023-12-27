//
//  LocationsListRouter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

class LocationsListRouter: LocationsListRouting {
    var detailRouter: LocationDetailRouting?
    var locationsListView: LocationsListView?
    
    func createLocationsList() -> LocationsListView {
        let interactor = LocationsListInteractor()
        let presenter = LocationsListPresenter(locationsListInteractor: interactor, locationMapper: LocationMapper(), router: self)
        locationsListView = LocationsListView(presenter: presenter)
        presenter.ui = locationsListView
        detailRouter = LocationDetailRouter()
        return locationsListView!
    }
    
    func showDetailLocation(withLocationURL locationURL: URL) {
        guard let locationsListView = locationsListView else {
            return
        }
        
        detailRouter?.showDetail(fromViewController: locationsListView, withLocationURL: locationURL)
    }
}
