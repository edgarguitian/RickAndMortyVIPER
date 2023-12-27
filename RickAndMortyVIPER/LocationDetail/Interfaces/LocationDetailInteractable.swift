//
//  LocationDetailInteractable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

protocol LocationDetailInteractable: AnyObject {
    func getDetailLocation(withURL url: URL) async -> LocationDetailEntity
}
