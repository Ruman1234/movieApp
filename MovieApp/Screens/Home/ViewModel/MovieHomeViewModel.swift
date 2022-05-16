//
//  MovieHomeViewModel.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
import Reachability
class MovieHomeViewModel:MoviesDataManabable{
    
    let reachability = try! Reachability()
    weak var delegate : MovieHomeProtocols?
    
    init(delegate : MovieHomeProtocols){
        self.delegate = delegate
    }
    
    func getMoviesData(){
        reachability.whenReachable = { [self] reach in
            hitApiCall()
        }
        reachability.whenUnreachable = { [self] _ in
            guard let arr =  self.getFromCash()?.results else {return}
            delegate?.movieDataProvider(arr)
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func hitApiCall() {
        NetworkManager.SharedInstance.getMovies { [self]  res in
            guard let arr = res.results else {return}
            self.pushToCache(response: res)
            delegate?.movieDataProvider(arr)
        } failure: { err in
            self.delegate?.showError(errorDesc: "There is no Data To Show")
        }
    }
    
    func addRemoveMovieFromDB(isAdd: Bool, data:MovieResultsArray) {
        let movie = MovieLocalDBModel(moviePoster: data.poster_path ?? "", movieName: data.title ?? "", releaseDate: data.release_date ?? "", favorite: true,backdrop_path: data.backdrop_path ?? "",overview: data.overview ?? "")
        if isAdd{
            CoreDataModel.shared.save_Create_Data(entityName: CoreDataConstants.entityName, key: CoreDataConstants.movie_Keys.movie.rawValue, value: movie)
        }else{
            CoreDataModel.shared.deleteData(entityName: CoreDataConstants.entityName, key: CoreDataConstants.movie_Keys.movie.rawValue, keyValue: movie)
        }
    }
}

extension MovieHomeViewModel{
    func getFromCash() -> MoviesModel? {
        if let cachedModel : MoviesModel = MRCacheManager.sharedManager.pullFromCache(Model:MoviesModel.self as AnyObject , modelType : "MoviesModel") as? MoviesModel {
            return cachedModel
        }
        return nil
    }
    
    func pushToCache(response :MoviesModel)  {
        MRCacheManager.sharedManager.pushToCache(Model: response, modelType: "MoviesModel")
    }
}
