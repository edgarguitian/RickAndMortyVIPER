//
//  LocationDetailRouting.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

protocol LocationDetailRouting: AnyObject {
    func showDetail(fromViewController: UIViewController,
                    withLocationURL locationURL: URL)
}
