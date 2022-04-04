//
//  ImageDetails.swift
//  Frontend_Test
//
//  Created by Big oh on 03/04/22.
//

import Foundation
struct ImageDetails: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
