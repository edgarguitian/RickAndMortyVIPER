//
//  CharacterDetailInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 26/12/23.
//

import Foundation
import Alamofire

class CharacterDetailInteractor: CharacterDetailInteractable {
    func getDetailCharacter(withURL url: URL) async -> CharacterDetailEntity {
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
                                    let jsonData = try JSONDecoder().decode(CharacterDetailEntity.self, from: data)
                                    continuation.resume(returning: jsonData)
                                } catch {
                                    fatalError("Error decoding character")
                                }
                            case let .failure(error):
                                fatalError("Error obtiendo character: "+error.localizedDescription)
                            }
                        }
                    }
        } catch {
            fatalError("Error obtiendo character")
        }
    }

}
