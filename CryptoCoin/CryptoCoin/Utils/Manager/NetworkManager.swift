//
//  NetworkManager.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/26/24.
//

import Foundation
import Combine

class NetworkManager {
    enum NetworkError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return " bad response from URL: \(url)"
            case .unknown:
                return "unknown error occured"
            }
        }
    }
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
       return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else  {
            throw NetworkError.badURLResponse(url: url)
        }
        print("market data 1= \(output.data) for url = \(url)")
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        
    }
}
