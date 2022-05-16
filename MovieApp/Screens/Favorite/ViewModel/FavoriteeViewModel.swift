//
//  FavoriteeViewModel.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation

class FavoriteeViewModel :MoviesDataManabable{
    
    weak var delegate : MovieHomeProtocols?
    private var movieResultsArray = [MovieResultsArray]()
    
    init(delegate : MovieHomeProtocols){
        self.delegate = delegate
    }
    
    func getMoviesData(){
        movieResultsArray.removeAll()
        let moviesArrayFromDB = CoreDataModel.shared.getMovieData()
        guard let moviesArrayFromDB = moviesArrayFromDB else {return}
        for movie in moviesArrayFromDB{
            let movie = MovieResultsArray(moviePoster: movie.moviePoster ?? "", movieName: movie.movieName ?? "", releaseDate: movie.releaseDate, backdrop_path: movie.backdrop_path ?? "",favorite: movie.favorite ?? false, overview: movie.overview ?? "")
            movieResultsArray.append(movie)
        }
        delegate?.movieDataProvider(movieResultsArray)
    }
    
    func addRemoveMovieFromDB(isAdd: Bool, data:MovieResultsArray) {
        let movie = MovieLocalDBModel(moviePoster: data.poster_path ?? "", movieName: data.title ?? "", releaseDate: data.release_date ?? "", favorite: true,backdrop_path: data.backdrop_path ?? "" ,overview:  data.overview ?? "")
        if isAdd{
            CoreDataModel.shared.save_Create_Data(entityName: CoreDataConstants.entityName, key: CoreDataConstants.movie_Keys.movie.rawValue, value: movie)
        }else{
            CoreDataModel.shared.deleteData(entityName: CoreDataConstants.entityName, key: CoreDataConstants.movie_Keys.movie.rawValue, keyValue: movie)
        }
    }
}
