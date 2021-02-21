//
//  MovieDetailVM.swift
//  Movies
//
//  Created by Orhan Erbas on 21.02.2021.
//

import Foundation

struct MovieDetailModel {
    let result : Movies
    
    var id : Int {
        return result.id
    }
    
    var poster_path : URL {
        return result.imageUrl()!
    }
    
    var title : String {
        return result.title!
    }
    
    var imdb_id : String {
        return result.imdb_id!
    }
    
    var vote_averange : Double {
        return Double(truncating: result.rating)
    }
    
    var release_date : String {
        return result.release_date!
    }
    
    var rating : NSDecimalNumber {
        return result.rating
    }
}
