//
//  MovieHomeProtocols.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
protocol MovieHomeProtocols:NSObject {
    func movieDataProvider(_ movieData: [MovieResultsArray])
    func showError(errorDesc:String)
}

protocol MoviesDataManabable{
    func getMoviesData()
    func addRemoveMovieFromDB(isAdd: Bool, data:MovieResultsArray)
}
