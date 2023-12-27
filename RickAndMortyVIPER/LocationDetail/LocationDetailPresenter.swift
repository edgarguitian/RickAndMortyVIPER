//
//  LocationDetailPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class LocationDetailPresenter: LocationDetailPresentable {
    private let locationDetailInteractor: LocationDetailInteractable
    let locationURL: URL
    private let locationDetailMapper: LocationDetailMapper
    var locationModel: LocationDetailViewModel?
    
    weak var ui: LocationDetailPresenterUI?
    
    init(locationDetailInteractor: LocationDetailInteractable, locationURL: URL, locationDetailMapper: LocationDetailMapper) {
        self.locationDetailInteractor = locationDetailInteractor
        self.locationURL = locationURL
        self.locationDetailMapper = locationDetailMapper
    }
    
    func onViewAppear() {
        Task {
            let model = await locationDetailInteractor.getDetailLocation(withURL: locationURL)
            locationModel = locationDetailMapper.map(entity: model)
            await MainActor.run {
                self.ui?.updateUI(viewModel: locationModel!)
            }
        }
    }
}
