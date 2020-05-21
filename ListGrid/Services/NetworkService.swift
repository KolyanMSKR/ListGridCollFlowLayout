//
//  NetworkService.swift
//  ListGrid
//
//  Created by Admin on 09.05.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import Foundation

class NetworkService {
    
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let httpStatusCode = (response as? HTTPURLResponse)?.statusCode else {
                completion(nil, error)
                
                return
            }
            
            if (200...299).contains(httpStatusCode) == false {
                return completion(nil, error)
            }
            
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
        
        task.resume()
    }
    
    func fetchJSONData<T: Codable>(of type: T.Type, request: URLRequest, completion: @escaping ([T]?) -> Void) {
        var req = request
        req.addValue("81c8e6fb-64d1-4e70-8a02-066afef28b2f", forHTTPHeaderField: "api_key")
        
        createDataTask(request: req) { data, error in
            guard let data = data else {
                return completion(nil)
            }
            
            do {
                let jsonData = try JSONDecoder().decode([T].self, from: data)
                completion(jsonData)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
}
