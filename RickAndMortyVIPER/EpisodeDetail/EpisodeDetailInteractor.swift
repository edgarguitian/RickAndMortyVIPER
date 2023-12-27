//
//  EpisodeDetailInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class EpisodeDetailInteractor: EpisodeDetailInteractable {
    func getDetailEpisode(withURL url: URL) async -> EpisodeDetailEntity {
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(EpisodeDetailEntity.self, from: data)

    }

}
