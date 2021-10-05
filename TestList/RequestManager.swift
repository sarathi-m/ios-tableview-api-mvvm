//
//  RequestManager.swift
//  TestList
//
//  Created by Parth Sarathi on 7/12/21.
//

import Foundation

enum NetworkError: Error {
    case UrlError
    case ServerError(description: String)
    case StatusCodeError(code: Int)
    case DataNotFoundError
    case ParseError(description: String)
    var description: String {
        switch self {
        case .UrlError:
            return "Invalid URL."
        case .ServerError(let desc):
            return "Server responded with the error \(desc)."
        case .DataNotFoundError:
            return "Data not found."
        case .ParseError(let desc):
            return "Parsing Error. \(desc)"
        case .StatusCodeError(let code):
            return "Error with status code \(code)"
        }
    }
}

class RequestManager {
    static func fetchData<T: Codable>(url: String, dataHandler: @escaping (Result<T, NetworkError>) -> ()) {
        guard let url = URL(string: url) else {
            return dataHandler(.failure(.UrlError))
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                dataHandler(.failure(.ServerError(description: error.localizedDescription)))
            }
            
            if let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode != 200 {
                dataHandler(.failure(.StatusCodeError(code: httpresponse.statusCode)))
            }
            
            guard let dataResponse = data else {
                return dataHandler(.failure(.DataNotFoundError))
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: dataResponse)
                dataHandler(.success(decodedData))
            }
            catch let err {
                dataHandler(.failure(.ParseError(description: err.localizedDescription)))
            }
        }.resume()
    }
}
