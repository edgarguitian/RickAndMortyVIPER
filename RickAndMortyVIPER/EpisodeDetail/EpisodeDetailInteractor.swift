//
//  EpisodeDetailInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import Alamofire

class EpisodeDetailInteractor: EpisodeDetailInteractable {
    func getDetailEpisode(withURL url: URL) async -> EpisodeDetailEntity {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                        AF.request(
                            url,
                            parameters: nil,
                            headers: nil,
                            requestModifier: nil
                        )
                        .responseData { response in
                            switch(response.result) {
                            case let .success(data):
                                do {
                                    let jsonData = try JSONDecoder().decode(EpisodeDetailEntity.self, from: data)
                                    continuation.resume(returning: jsonData)
                                } catch {
                                    fatalError("Error decoding episodios")
                                }
                            case let .failure(error):
                                fatalError("Error obtiendo episodios: "+error.localizedDescription)
                            }
                        }
                    }
        } catch {
            fatalError("Error obtiendo episodios")
        }
    }

}
