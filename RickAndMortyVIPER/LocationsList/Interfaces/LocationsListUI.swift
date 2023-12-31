//
//  LocationsListUI.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

protocol LocationsListUI: AnyObject {
    func update(locations: [LocationCellViewModel])
}
