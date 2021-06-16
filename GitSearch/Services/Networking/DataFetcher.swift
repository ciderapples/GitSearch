//
//  DataFetcher.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/16/21.
//

import Foundation

typealias DataFetchCompletion = (Result<Data, Error>) -> Void

protocol DataFetching {
    func fetchData(with request: URLRequest, deliverQueue: DispatchQueue, completion: @escaping DataFetchCompletion)
}

struct DataFetcher: DataFetching {
    
    let urlSession = URLSession.shared
    
    func fetchData(with request: URLRequest, deliverQueue: DispatchQueue = .main, completion: @escaping DataFetchCompletion) {
        let dataTask = dataTask(with: request) { result in
            switch result {
            case .success(let data):
                deliverQueue.async { completion(.success(data)) }
            case .failure(let error):
                deliverQueue.async { completion(.failure(error)) }
            }
        }
        
        dataTask.resume()
    }
    
    private func dataTask(with request: URLRequest, completion: @escaping DataFetchCompletion) -> URLSessionDataTask {
        urlSession.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(data ?? Data()))
        }
    }
}
