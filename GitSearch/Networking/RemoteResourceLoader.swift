//
//  RemoteResourceLoader.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/16/21.
//

import Foundation

protocol NetworkServiceProvider {
    var dataFetcher: DataFetching { get }
}

class RemoteResourceLoader<T: NetworkRequest>: NetworkServiceProvider {
    
    enum RemoteResourceError: Error {
        case invalidUrlRequest
    }
    
    var dataFetcher: DataFetching
    
    init(dataFetcher: DataFetching = DataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func load<Resource>(
        networkRequest: T,
        resourceType: Resource.Type,
        completion: @escaping (Result<Resource, Error>) -> Void
    ) where Resource: Decodable {
        guard let request = networkRequest.makeRequest() else {
            completion(.failure(RemoteResourceError.invalidUrlRequest))
            return
        }
        
        dataFetcher.fetchData(with: request, deliverQueue: .main) { result in
            switch result {
            case .success(let data):
                do {
                    let decodable = try JSONDecoder().decode(resourceType, from: data)
                    completion(.success(decodable))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
