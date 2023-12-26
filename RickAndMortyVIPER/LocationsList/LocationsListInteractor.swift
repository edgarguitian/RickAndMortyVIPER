//
//  LocationsListInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class LocationsListInteractor: LocationsListInteractable {
    func getLocationsList() async -> LocationsResponseEntity {
        let url = URL(string: "https://rickandmortyapi.com/api/location")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(LocationsResponseEntity.self, from: data)
    }
}