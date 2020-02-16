//
//  RequestAPI.swift
//  Test app
//
//  Created by Anton on 2/14/20.
//  Copyright © 2020 falli_ot. All rights reserved.
//

import Foundation
 
/// This is an enumeration of the possible errors when contacting the API

enum APIError:Error
{
    case responseProblem
    case decodeProblem
    case encodeProblem
}

/**
 
 API structure
 
## Server
 
 ````
 let responseString = "https://testapp.requestcatcher.com"
 ```
## Save function
 
 Function that sends the information on the server
 
 ````
 func save(_ dimensionsToSave: Dimensions, completion: @escaping(Result<Dimensions, APIError>) -> Void)
 ```
 
 */
struct APIRequest {
    
    let resourseURL: URL

    init() {
        
        let responseString = "https://testapp.requestcatcher.com"
        guard let resourseURL = URL(string: responseString) else {fatalError()}

        self.resourseURL = resourseURL
    }


    func save(_ dimensionsToSave: Dimensions, completion: @escaping(Result<Dimensions, APIError>) -> Void)
    {
     do {
        var urlRequest = URLRequest(url: resourseURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(dimensionsToSave)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
            }
            do {
                let dimensionsData = try JSONDecoder().decode(Dimensions.self, from: jsonData)
                completion(.success(dimensionsData))
            } catch let error{
                completion(.failure(.decodeProblem))
                print(error)
            }
        }
        dataTask.resume()
     } catch {
        completion(.failure(.encodeProblem))
        }
    }
}


