//
//  LocationsListPresentable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

protocol LocationsListPresentable: AnyObject {
    var locationListUI: LocationsListUI? { get }
    var locationsModels: [LocationCellViewModel] { get }
    func onViewAppear()
    func loadMoreData()
    func onTapCell(atIndex: Int)
}
