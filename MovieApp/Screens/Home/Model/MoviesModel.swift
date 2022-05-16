//
//  MoviesModel.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
import ObjectMapper

class MoviesModel : Mappable {
    var page : Int?
    var results : [MovieResultsArray]?
    var total_pages : Int?
    var total_results : Int?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        page <- map["page"]
        results <- map["results"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
    }

}

class MovieResultsArray : Mappable {
    var adult : Bool?
    var backdrop_path : String?
    var genre_ids : [Int]?
    var id : Int?
    var original_language : String?
    var original_title : String?
    var overview : String?
    var popularity : Double?
    var poster_path : String?
    var release_date : String?
    var title : String?
    var video : Bool?
    var vote_average : Double?
    var vote_count : Int?
    var favorite : Bool?

    init(moviePoster : String , movieName:String,releaseDate:String,backdrop_path:String,favorite:Bool = false,overview:String) {
        self.poster_path = moviePoster
        self.title = movieName
        self.release_date = releaseDate
        self.backdrop_path = backdrop_path
        self.favorite = favorite
        self.overview = overview
    }
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {

        adult <- map["adult"]
        backdrop_path <- map["backdrop_path"]
        genre_ids <- map["genre_ids"]
        id <- map["id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        title <- map["title"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
    }

}
