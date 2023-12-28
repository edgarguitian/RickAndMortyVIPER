//
//  EpisodesListInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation

class EpisodesListInteractor: EpisodesListInteractable {
    func getEpisodesList(page: Int) async -> EpisodesResponseEntity {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/?page=" + String(page)) else {
            fatalError("Error en la url de episodios")
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(EpisodesResponseEntity.self, from: data)
            return decodedData
        } catch {
            fatalError("Error en el decode de episodios")
        }
    }
}
