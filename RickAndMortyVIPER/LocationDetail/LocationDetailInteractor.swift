//
//  LocationDetailInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class LocationDetailInteractor: LocationDetailInteractable {
    func getDetailLocation(withURL url: URL) async -> LocationDetailEntity {
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(LocationDetailEntity.self, from: data)

    }

}
