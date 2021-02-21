//
//  NowPlayingVM.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import Foundation

struct NowPlayingListViewModel {
    let moviesList : NowPlaying
    
    func numberOfRowSelection() -> Int {
        return self.moviesList.movies.count
    }
    
    func moviesAtIndex(_ index : Int) -> NowPlayingViewModel {
        let movies = self.moviesList.movies[index]
        return NowPlayingViewModel(result: movies)
    }
}

struct NowPlayingViewModel {
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

}
