//
//  HomeList.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import Foundation

struct Movies : Decodable {
        let id: Int
        let title: String?
        let overview: String?
        let poster: String?
        let release_date: String?
        let imdb_id: String?
        private var voteAverage: Decimal
        var rating: NSDecimalNumber {
            get { return NSDecimalNumber(decimal: voteAverage) }
        }

    init(id: Int, title: String, overview: String, poster: String, release_date: String, imdb_id: String, voteAverage: Decimal) {
            self.id = id
            self.title = title
            self.overview = overview
            self.poster = poster
            self.release_date = release_date
            self.imdb_id = imdb_id
            self.voteAverage = voteAverage
        }

        func imageUrl() -> URL? {
            return URL(string: "\(Constants.imagesBaseURL)\(poster ?? "")")
        }

        enum CodingKeys: String, CodingKey {
            case id, title, overview, release_date, imdb_id
            case poster = "poster_path"
            case voteAverage = "vote_average"
        }
}
