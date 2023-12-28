//
//  LocationsListPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class LocationsListPresenter: LocationsListPresentable {
    weak var locationListUI: LocationsListUI?
    private let locationsListInteractor: LocationsListInteractable
    var locationsModels: [LocationCellViewModel] = []
    private var models: [LocationsEntity] = []
    private let locationMapper: LocationMapper
    private let router: LocationsListRouting
    private var currentPage: Int = 1
    private var numPages: Int = -1

    init(locationsListInteractor: LocationsListInteractable,
         locationMapper: LocationMapper,
         router: LocationsListRouting) {
        self.locationsListInteractor = locationsListInteractor
        self.locationMapper = locationMapper
        self.router = router
    }

    func onViewAppear() {
        if numPages == -1 {
            loadLocations(page: currentPage)
        }

    }

    func loadLocations(page: Int) {
        if numPages == -1 || page <= numPages {
            Task {
                let locationsResult = await locationsListInteractor.getLocationsList(page: page)
                numPages = locationsResult.info.pages
                let newLocations = locationsResult.results
                let newModels = newLocations.map(locationMapper.map(entity:))
                locationsModels.append(contentsOf: newModels)
                locationListUI?.update(locations: locationsModels)
            }
        }
    }

    func onTapCell(atIndex: Int) {
        let locationURL = locationsModels[atIndex].locationURL
        guard let locationURL = locationURL else {
            return
        }
        router.showDetailLocation(withLocationURL: locationURL)
    }

    func loadMoreData() {
        currentPage += 1
        loadLocations(page: currentPage)
    }
}
