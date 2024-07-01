//
//  REST.swift
//  Carangas
//
//  Created by Vitoria Ortega on 26/06/24.
//  Copyright © 2024 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class REST {
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadBrands(onComplete: @escaping ([Brand]?) -> Void) {
        guard let url = URL(string: "https://parallelum.com.br/fipe/api/v1/carros/marcas") else {
            onComplete(nil)
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
               onComplete(nil)
                return
            }
            if response.statusCode == 200 {
                guard let data = data else {return}
                do {
                    let brands = try JSONDecoder().decode([Brand].self, from: data)
                    onComplete(brands)
                } catch {
                    onComplete(nil)
                }
            } else {
                onComplete(nil)
            }
        }
        dataTask.resume()
    }
    
    
    class func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                onError(.taskError(error: error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                onError(.noResponse)
                return
            }
            if response.statusCode == 200 {
                guard let data = data else {
                    onError(.noData)
                    return
                }
                do {
                    let cars = try JSONDecoder().decode([Car].self, from: data)
                    onComplete(cars)
                } catch {
                    onError(.invalidJSON)
                }
            } else {
                onError(.responseStatusCode(code: response.statusCode))
            }
        }
        dataTask.resume()
    }
    
    class func save(car: Car, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        
        // Imprime o JSON que está sendo enviado
        if let jsonString = String(data: json, encoding: .utf8) {
            print("JSON Payload: \(jsonString)")
        }
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                onComplete(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                
                if (200...299).contains(httpResponse.statusCode) {
                    onComplete(true)
                    return
                }
            }
            
            if let data = data {
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
            }
            
            onComplete(false)
        }
        dataTask.resume()
    }
    
    class func update(car: Car, onComplete: @escaping (Bool) -> Void) {
        guard let id = car._id, let url = URL(string: "\(basePath)/\(id)") else {
            onComplete(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                onComplete(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                
                if (200...299).contains(httpResponse.statusCode) {
                    onComplete(true)
                    return
                }
            }
            
            if let data = data {
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
            }
            
            onComplete(false)
        }
        dataTask.resume()
    }

class func delete(car: Car, onComplete: @escaping (Bool) -> Void) {
     guard let id = car._id, let url = URL(string: "\(basePath)/\(id)") else {
         onComplete(false)
         return
     }
     var request = URLRequest(url: url)
     request.httpMethod = "DELETE"
     request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
     let dataTask = session.dataTask(with: request) { (data, response, error) in
         if let error = error {
             print("Error: \(error.localizedDescription)")
             onComplete(false)
             return
         }
         
         if let httpResponse = response as? HTTPURLResponse {
             print("HTTP Status Code: \(httpResponse.statusCode)")
             
             if (200...299).contains(httpResponse.statusCode) {
                 onComplete(true)
                 return
             }
         }
         
         if let data = data {
             print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
         }
         
         onComplete(false)
     }
     dataTask.resume()
 }
}
