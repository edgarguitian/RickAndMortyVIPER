//
//  LocationsListInteractable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

protocol LocationsListInteractable: AnyObject {
    func getLocationsList(page: Int) async -> LocationsResponseEntity
}
