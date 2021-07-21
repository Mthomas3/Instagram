//
//  User.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import Foundation

struct User: Decodable {
    let username: String
    let pictureURL: String
    let stories: [Story]
}

struct Users: Decodable {
    let users: [User]
}
