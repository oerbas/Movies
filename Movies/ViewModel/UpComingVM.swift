//
//  MoviesVM.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import Foundation

struct UpComingListViewModel {
    let moviesList : UpComing
    
    func numberOfRowSelection() -> Int {
        return self.moviesList.movies.count
    }
    
    func moviesAtIndex(_ index : Int) -> UpComingViewModel {
        let movies = self.moviesList.movies[index]
        return UpComingViewModel(result: movies)
    }
}

struct UpComingViewModel {
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
