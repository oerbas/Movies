//
//  Search.swift
//  Movies
//
//  Created by Orhan Erbas on 21.02.2021.
//

import Foundation

struct Search : Decodable {
    var movies: [Movies]
    var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case totalPages = "total_pages"
    }
}
