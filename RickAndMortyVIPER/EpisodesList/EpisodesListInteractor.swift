//
//  EpisodesListInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class EpisodesListInteractor: EpisodesListInteractable {
    func getEpisodesList() async -> EpisodesResponseEntity {
        let url = URL(string: "https://rickandmortyapi.com/api/episode")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(EpisodesResponseEntity.self, from: data)
    }
}