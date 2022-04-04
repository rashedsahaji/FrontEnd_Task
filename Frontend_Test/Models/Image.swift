//
//  Image.swift
//  Frontend_Test
//
//  Created by Big oh on 02/04/22.
//

import Foundation

struct MyResultElement: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias MyResult = [MyResultElement]

/*
 API output
{
    "id": "0",
    "author": "Alejandro Escamilla",
    "width": 5616,
    "height": 3744,
    "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
    "download_url": "https://picsum.photos/id/0/5616/3744"
}
 */
