//
//  SearchVM.swift
//  Movies
//
//  Created by Orhan Erbas on 21.02.2021.
//

import Foundation

struct SearchListViewModel {
    let moviesList : Search
    
    func numberOfRowSelection() -> Int {
        return self.moviesList.movies.count
    }
    
    func moviesAtIndex(_ index : Int) -> SearchViewModel {
        let movies = self.moviesList.movies[index]
        return SearchViewModel(result: movies)
    }
}

struct SearchViewModel {
    let result : Movies
    
    var id : Int {
        return result.id
    }

    
    var title : String {
        return result.title!
    }

}
