//
//  SimilarVM.swift
//  Movies
//
//  Created by Orhan Erbas on 21.02.2021.
//

import Foundation

struct SimilarListViewModel {
    let moviesList : Similar
    
    func numberOfRowSelection() -> Int {
        return self.moviesList.movies.count
    }
    
    func moviesAtIndex(_ index : Int) -> SimilarViewModel {
        let movies = self.moviesList.movies[index]
        return SimilarViewModel(result: movies)
    }
}

struct SimilarViewModel {
    let result : Movies
    
    var id : Int {
        return result.id
    }
    
    var overview : String {
        return result.overview!
    }
    
    var poster_path : URL {
        return result.imageUrl()!
    }
    
    var release_date : String {
        return result.release_date!
    }
    
    var title : String {
        return result.title!
    }

}

