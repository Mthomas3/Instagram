//
//  RequestService.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import Foundation

extension URLSession {

    @discardableResult func resumeDataTask<T: Decodable>(with url: URL, withTypedResponse response: @escaping (Result<T, APIServiceError>)->Void) -> URLSessionDataTask {
        let task = dataTask(with: url, withTypedResponse: response)
        task.resume()
        return task
    }

    @discardableResult func dataTask<T: Decodable>(with url: URL, withTypedResponse response: @escaping (Result<T, APIServiceError>)->Void) -> URLSessionDataTask {
        return dataTask(with: url, usingResult: { result in
            switch result {
            case .success(let (_, data)):
                let decoder = JSONDecoder()
                do {
                    let decodedTypeResponse = try decoder.decode(T.self, from: data)
                    response(.success(decodedTypeResponse))
                } catch {
                    response(.failure(.decodeError))
                }
                break
            case .failure:
                response(.failure(.apiError))
                break
            }
        })
    }

    @discardableResult func dataTask(with url: URL, usingResult result: @escaping (Result<(URLResponse, Data), APIServiceError>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                return result(.failure(.apiError))
            }

            guard let response = response, let data = data else {
                result(.failure(.invalidResponse))
                return
            }

            result(.success((response, data)))
        }
    }
}

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
    case invalidUrl
}
