//
//  NetworkManager.swift
//  UrlApplication 3.02
//
//  Created by Бийбол Зулпукаров on 1/9/23.
//

import Foundation

enum Link: String {
    case price = "https://api.nbp.pl/api/cenyzlota/last/30/?format=json#"
}


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String?, with completion: @escaping(Result<T, NetworkError>) -> Void) {

        guard let stringURL = url, let url = URL(string: stringURL) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            let decoder = JSONDecoder()

            do {
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }
}
