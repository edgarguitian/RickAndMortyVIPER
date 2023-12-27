//
//  LocationsListPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class LocationsListPresenter: LocationsListPresentable {
    weak var ui: LocationsListUI?
    private let locationsListInteractor: LocationsListInteractable
    var locationsModels: [LocationCellViewModel] = []
    private var models: [LocationsEntity] = []
    private let locationMapper: LocationMapper
    private let router: LocationsListRouting
    
    init(locationsListInteractor: LocationsListInteractable,
         locationMapper: LocationMapper,
         router: LocationsListRouting) {
        self.locationsListInteractor = locationsListInteractor
        self.locationMapper = locationMapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            models = await locationsListInteractor.getLocationsList().results
            locationsModels = models.map(locationMapper.map(entity:))
            ui?.update(locations: locationsModels)
        }
        
    }
    
    func onTapCell(atIndex: Int) {
        let locationURL = models[atIndex].urlLocation
        guard let locationURL = URL(string: locationURL) else {
            return
        }
        router.showDetailLocation(withLocationURL: locationURL)
    }
}
