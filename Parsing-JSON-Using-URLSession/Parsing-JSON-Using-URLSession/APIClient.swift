//
//  APIClient.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Liubov Kaper  on 8/4/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation


// TODO: convert to generic APIClient
// Conform APIClient to Decodable

enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}

class APIClient {
    
    // the fetchData method does an asychronous network call
    // this means that the method returns BEFORE the request is complete
    // when dealing with  asychronous calls we use a closure
    // other mechanisms include: delegation, NotificationCenter
    // newer to iOS developers as of iOS 13 is Combine
    
    // closures capture values, its a REFERENCE TYPE
    
    //HAS TO BE CLOSURE HERE
    func fetchData(completion: @escaping (Result<[Station], AppError>) -> ()) {
        let endpoint = "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"
      
        // "prospect park""https://gbfs.citibikenyc.com/gbfs/en/station_information.json".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        //1. we need a URL to create our Network Request
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        //2. create a GET request, other request examples POST, FDELETE, PATCH, PUT
        
        let request = URLRequest(url: url)
        
        //CAN PUT MANY REQUESTS>...
       // request.httpMethod = "GET"
       // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // 3. use URLSession to make Network Request
        // URLSession is a singleton
        // this is sufficient to use for making most requests
        // using URLSession without shared gives you access to adding necessary configurations to your task
        
        //ALWAYS CREATE THIS VARIABLE, SO YOU DONT FORGET .resume() at the end
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            if let data = data {
                // 4. decode JSON to our SWift model
                do {
                    let results = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    completion(.success(results.data.stations))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
