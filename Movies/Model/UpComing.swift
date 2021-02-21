//
//  Results.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import Foundation

struct UpComing : Decodable {
    var movies: [Movies]
    var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case totalPages = "total_pages"
    }
}
