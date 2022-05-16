//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Ruman on 15/05/2022.
//

import Foundation

protocol MovieDetailsDelegate : NSObject{
    func addRemoveMovieFromDB(isAdd: Bool, data:MovieResultsArray)
}

protocol MovieDetailsViewModelDelegate :NSObject{
    func removeFromFavItmes(res:Bool)
}

class MovieDetailsViewModel : NSObject{
    weak var delegate : MovieDetailsViewModelDelegate?
    
    init(delegate :MovieDetailsViewModelDelegate ){
        self.delegate = delegate
    }
}

extension MovieDetailsViewModel: MovieDetailsDelegate
{
    func addRemoveMovieFromDB(isAdd: Bool, data:MovieResultsArray){
        let movie = MovieLocalDBModel(moviePoster: data.poster_path ?? "", movieName: data.title ?? "", releaseDate: data.release_date ?? "", favorite: true,backdrop_path: data.backdrop_path ?? "",overview: data.overview ?? "" )
        if isAdd{
            CoreDataModel.shared.save_Create_Data(entityName: CoreDataConstants.entityName, key: CoreDataConstants.movie_Keys.movie.rawValue, value: movie)
        }else{
            CoreDataModel.shared.deleteData(entityName: CoreDataConstants.entityName, key: CoreDataConstants.movie_Keys.movie.rawValue, keyValue: movie)
        }
        self.delegate?.removeFromFavItmes(res: true)
    }
        
    
}
