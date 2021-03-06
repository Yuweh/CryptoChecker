//
//  CryptoService.swift
//  CryptoChecker
//
//  Created by Jay Bergonia on 4/30/22.
//

import Foundation
import Combine

final class CryptoService {
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host  = "api.coinranking.com"
        components.path  = "/v2/coins"
        components.queryItems = [URLQueryItem(name: "base", value: "USD"), URLQueryItem(name: "timePeriod", value: "24h")]
        return components
    }
    
    func fetchCoins() -> AnyPublisher<CryptoDataContainer, Error> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: CryptoDataContainer.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

struct CryptoDataContainer: Decodable {
    let status: String
    let data: CyptoData
    
}

struct CyptoData: Decodable {
    let coins: [Coin]
    
}

struct Coin: Decodable, Hashable {
    let name: String
    let price: String
    
}
