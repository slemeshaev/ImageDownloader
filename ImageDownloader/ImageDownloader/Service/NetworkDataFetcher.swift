//
//  NetworkDataFetcher.swift
//  ImageDownloader
//
//  Created by Станислав Лемешаев on 05.03.2021.
//

import UIKit

final class NetworkDataFetcher {
    
    private var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, numberPage: Int, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTerm: searchTerm, n: numberPage) { (data, error) in
            if let error = error {
                print("Error received requestion data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON \(jsonError)")
            return nil
        }
    }
    
}

