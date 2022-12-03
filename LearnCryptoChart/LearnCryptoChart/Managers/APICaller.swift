//
//  APICaller.swift
//  Load More List
//
//  Created by Ikhwan on 17/10/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseURL = "https://instyo.github.io/scheme_tester"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    public func getCryptoList(completion: @escaping (Result<[CryptoModel], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/cryptos.json"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(CryptoResponse.self, from: data)
                    
                    completion(.success(result.assets))
                }
                catch {
                    print(String(describing: error)) // <- ✅ Use this for debuging!
                    completion(.failure(error))
                }
            }
            
            return task.resume()
        }
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void) {
            guard let url = url else {
                return
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
}
