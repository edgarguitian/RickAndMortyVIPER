//
//  LocationsListRouting.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

protocol LocationsListRouting: AnyObject {
    var detailRouter: LocationDetailRouting? { get }
    var locationsListView: LocationsListView? { get }
    
    func showLocationsList(window: UIWindow?)
    func showDetailLocation(withLocationURL locationURL: URL)
}
