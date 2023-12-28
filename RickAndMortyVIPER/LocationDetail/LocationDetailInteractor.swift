//
//  LocationDetailInteractor.swift
//  RickAndMortyVIPER
//
//  Created by Edgar Guitian Rey on 27/12/23.
//

import Foundation
import Alamofire

class LocationDetailInteractor: LocationDetailInteractable {
    func getDetailLocation(withURL url: URL) async -> LocationDetailEntity {
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
                                    let jsonData = try JSONDecoder().decode(LocationDetailEntity.self, from: data)
                                    continuation.resume(returning: jsonData)
                                } catch {
                                    fatalError("Error decoding locations")
                                }
                            case let .failure(error):
                                fatalError("Error obtiendo locations: "+error.localizedDescription)
                            }
                        }
                    }
        } catch {
            fatalError("Error obtiendo locations")
        }
    }

}
