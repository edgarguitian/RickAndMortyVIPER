//
//  EpisodeDetailRouting.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import UIKit

protocol EpisodeDetailRouting: AnyObject {
    func showDetail(fromViewController: UIViewController,
                    withEpisodeURL episodeURL: URL)
}
