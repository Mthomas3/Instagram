//
//  Story.swift
//  Instagram
//
//  Created by Thomas on 21/07/2021.
//

import Foundation

struct Story: Decodable {
    let imageURL: String?
    let videoURL: String?
    let uploadedAt: String
    let duration: Int
}
