//
//  EndPoint.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import Foundation

enum EndPoints: String {
    case Profiles = "https://api.jsonbin.io/b/60f756fca917050205cc87a3"
}

enum UserService {

    static func getUsers(completion: @escaping (Result<Users, APIServiceError>) -> Void) {
        guard let url = URL(string: EndPoints.Profiles.rawValue) else {
            return completion(.failure(.invalidUrl))
        }

        URLSession.shared.resumeDataTask(with: url, withTypedResponse: completion)
    }
    
}
