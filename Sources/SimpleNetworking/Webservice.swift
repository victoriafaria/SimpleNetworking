//
//  Webservice.swift
//  HelloSPM
//
//  Created by Victoria Faria on 21/08/23.
//

import Foundation

public enum NetworkError: Error {
    case badRequest
    case decodingError
}

public class Webservice {
    
    public init() { }
    
     public func fetch<T: Codable>(url: URL, parse: @escaping (Data) -> T?, completion: @escaping (Result<T?, NetworkError>) -> Void)  {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(.failure(.decodingError))
                return
            }
            let result = parse(data)
            completion(.success(result))
            
        }.resume()
    }
}
