//
//  CharacterDetailPresentable.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation

protocol CharacterDetailPresentable: AnyObject {
    var ui: CharacterDetailPresenterUI? { get }
    var characterURL: URL { get }
    var characterModel: CharacterDetailViewModel? { get }
    func onViewAppear()
    func onTapCell(atIndex: Int)
}
