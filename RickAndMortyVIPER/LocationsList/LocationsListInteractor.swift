//
//  LocationsListInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

class LocationsListInteractor: LocationsListInteractable {
    func getLocationsList(page: Int) async -> LocationsResponseEntity {
        guard let url = URL(string: "https://rickandmortyapi.com/api/location/?page=" + String(page)) else {
            fatalError("Error en la url de locations")
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(LocationsResponseEntity.self, from: data)
            return decodedData
        } catch {
            fatalError("Error en el decode de locations")
        }
    }
}
