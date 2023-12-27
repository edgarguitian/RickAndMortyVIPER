//
//  LocationDetailPresentable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

protocol LocationDetailPresentable: AnyObject {
    var ui: LocationDetailPresenterUI? { get }
    var locationURL: URL { get }
    var locationModel: LocationDetailViewModel? { get }
    func onViewAppear()
    func onTapCell(atIndex: Int)
}
