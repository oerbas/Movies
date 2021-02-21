//
//  HomeService.swift
//  Movies
//
//  Created by Orhan Erbas on 20.02.2021.
//

import Foundation
import Alamofire

class ApiManager {
    
    static let instance = ApiManager()
    private init() { }
    
    func getUpComingList(success successCallback: @escaping (UpComing?) -> Void){
        let request = AF.request("\(Constants.baseURL)\(Constants.upComingPath)", parameters: Constants.apiKey)
        
        request.responseDecodable(of: UpComing.self) { (response) in
            guard let upcoming = response.value else { return }
            DispatchQueue.main.async {
                successCallback(upcoming)
            }
        }
    }
    
    func getNowPlayingList(success successCallback: @escaping (NowPlaying?) -> Void){
        let request = AF.request("\(Constants.baseURL)\(Constants.nowPlayingPath)", parameters: Constants.apiKey)
        
        request.responseDecodable(of: NowPlaying.self) { (response) in
            guard let upcoming = response.value else { return }
            DispatchQueue.main.async {
                successCallback(upcoming)
            }
        }
    }
    
    func getMovieDetail(movieId: Int, success successCallback: @escaping (Movies?) -> Void){
        let request = AF.request("\(Constants.baseURL)\(Constants.movieDetail)\(movieId)", parameters: Constants.apiKey)
        request.responseDecodable(of: Movies.self) { (response) in
            guard let detail = response.value else { return }
            DispatchQueue.main.async {
                successCallback(detail)
            }
        }
    }
    
    func getSimilarList(movieId: Int, success successCallback: @escaping (Similar?) -> Void){
        let request = AF.request("\(Constants.baseURL)\(Constants.movieDetail)\(movieId)\("/similar")", parameters: Constants.apiKey)
        request.responseDecodable(of: Similar.self) { (response) in
            guard let upcoming = response.value else { return }
            print("orhan",Constants.apiKey)
            DispatchQueue.main.async {
                successCallback(upcoming)
            }
        }
    }
    
    func getSearchResult(q: String, success successCallback: @escaping (Similar?) -> Void){
        let params : [String : Any] = [
            "q" : q,
            "api_key" : Constants.apiKey
        ]
        let request = AF.request("\(Constants.baseURL)\(Constants.searchMoviePath)", parameters: params)
        request.responseDecodable(of: Similar.self) { (response) in
            guard let searched = response.value else { return }
            DispatchQueue.main.async {
                
                successCallback(searched)
            }
        }
    }
}
