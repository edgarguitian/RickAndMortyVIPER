//
//  LocationDetailPresenter.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class LocationDetailPresenter: LocationDetailPresentable {
    private let locationDetailInteractor: LocationDetailInteractable
    private let characterDetailInteractor: CharacterDetailInteractable
    let locationURL: URL
    private let locationDetailMapper: LocationDetailMapper
    var locationModel: LocationDetailViewModel?
    private let characterDetailMapper: CharacterDetailMapper
    private let router: LocationDetailRouting
    private var infoResidents: [CharacterDetailViewModel] = []
    weak var locationDetailUI: LocationDetailPresenterUI?

    init(locationDetailInteractor: LocationDetailInteractable,
         characterDetailInteractor: CharacterDetailInteractable,
         locationURL: URL,
         locationDetailMapper: LocationDetailMapper,
         characterDetailMapper: CharacterDetailMapper,
         router: LocationDetailRouting) {
        self.locationDetailInteractor = locationDetailInteractor
        self.characterDetailInteractor = characterDetailInteractor
        self.locationURL = locationURL
        self.locationDetailMapper = locationDetailMapper
        self.characterDetailMapper = characterDetailMapper
        self.router = router
    }

    func onViewAppear() {
        Task {
            let model = await locationDetailInteractor.getDetailLocation(withURL: locationURL)
            for characterItem in 0..<model.residents.count {
                let url = URL(string: model.residents[characterItem])!
                let character = await characterDetailInteractor.getDetailCharacter(withURL: url)
                let characterModel = characterDetailMapper.map(entity: character, episodes: [])
                infoResidents.append(characterModel)
            }
            locationModel = locationDetailMapper.map(entity: model, residents: infoResidents)
            await MainActor.run {
                self.locationDetailUI?.updateUI(viewModel: locationModel!)
            }
        }
    }

    func onTapCell(atIndex: Int) {
        let residentURL = infoResidents[atIndex].urlCharacter
        guard let residentURL = residentURL else {
            return
        }
        router.showDetailResident(withResidentURL: residentURL)
    }
}
