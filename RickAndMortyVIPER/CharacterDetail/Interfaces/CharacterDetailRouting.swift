//
//  CharacterDetailRouting.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import UIKit

protocol CharacterDetailRouting: AnyObject {
    func showDetail(fromViewController: UIViewController,
                    withCharacterURL characterURL: URL)
}
