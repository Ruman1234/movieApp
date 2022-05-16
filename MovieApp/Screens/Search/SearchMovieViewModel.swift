//
//  SearchMovieViewModel.swift
//  MovieApp
//
//  Created by Ruman on 14/05/2022.
//

import Foundation
protocol SearchMovieViewProtocol{
    func getMoviesData(bySearch text : String)
    func getSearchsFromDB() -> [String]?
    func saveSearchesToDB(str:String)
}
class SearchMovieViewModel : SearchMovieViewProtocol{
    
    weak var delegate : MovieHomeProtocols?
    private var liveSearchKey = "liveSearch"
    private var liveSearchArray = [String]()
    init(delegate : MovieHomeProtocols){
        self.delegate = delegate
    }
    
    func getMoviesData(bySearch text: String) {
        NetworkManager.SharedInstance.getMoviesBySearch(searchText: text) { [self] res in
            guard let arr = res.results else {return}
            if arr.isEmpty{
                self.delegate?.showError(errorDesc: "There is no Data To Show")
                return
            }
            delegate?.movieDataProvider(arr)
        } failure: { err in
            self.delegate?.showError(errorDesc: "There is no Data To Show")
        }
    }
    
    func getSearchsFromDB() -> [String]?{
        let searchArrayLocal = MRCacheManager.sharedManager.pullFromCache(Key: liveSearchKey, type: .local) as? [String]
        return searchArrayLocal
    }
    
    func saveSearchesToDB(str:String){
        let searchArrayLocal = getSearchsFromDB()
        if let searchArrayLocal = searchArrayLocal{
            liveSearchArray = searchArrayLocal
        }
        if liveSearchArray.count >= 10{
            liveSearchArray.removeLast()
        }
        liveSearchArray.insert(str, at: 0)
        MRCacheManager.sharedManager.pushToCache(Value: liveSearchArray as AnyObject, Key: liveSearchKey, type: .local)
    }
    
}
