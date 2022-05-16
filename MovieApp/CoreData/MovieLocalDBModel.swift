//
//  MovieLocalDBModel.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
import CoreData

public class MovieLocalDBModel : NSObject, NSCoding{
    
    public var moviePoster : String?
    public var backdrop_path : String?
    public var movieName : String?
    public var releaseDate : String
    public var overview : String?
    public var favorite : Bool?
    
    enum Key :String {
        case moviePoster = "moviePoster"
        case movieName = "movieName"
        case releaseDate = "releaseDate"
        case favorite = "favorite"
        case backdrop_path = "backdrop_path"
        case overview = "overview"
    }
    
    init(moviePoster : String , movieName:String,releaseDate:String,favorite:Bool,backdrop_path:String,overview:String) {
        self.moviePoster = moviePoster
        self.movieName = movieName
        self.releaseDate = releaseDate
        self.favorite = favorite
        self.backdrop_path = backdrop_path
        self.overview = overview
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(moviePoster, forKey: Key.moviePoster.rawValue)
        coder.encode(movieName, forKey: Key.movieName.rawValue)
        coder.encode(releaseDate, forKey: Key.releaseDate.rawValue)
        coder.encode(favorite, forKey: Key.favorite.rawValue)
        coder.encode(backdrop_path, forKey: Key.backdrop_path.rawValue)
        coder.encode(overview, forKey: Key.overview.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let moviePoster = coder.decodeObject(forKey: Key.moviePoster.rawValue) as! String
        let movieName = coder.decodeObject(forKey: Key.movieName.rawValue) as! String
        let releaseDate = coder.decodeObject(forKey: Key.releaseDate.rawValue) as! String
        let favorite = coder.decodeObject(forKey: Key.favorite.rawValue) as! Bool
        let backdrop_path = coder.decodeObject(forKey: Key.backdrop_path.rawValue) as! String
        let overview = coder.decodeObject(forKey: Key.overview.rawValue) as! String
        self.init(moviePoster: moviePoster, movieName: movieName,releaseDate:releaseDate, favorite: favorite,backdrop_path:backdrop_path,overview: overview)
    }
}
