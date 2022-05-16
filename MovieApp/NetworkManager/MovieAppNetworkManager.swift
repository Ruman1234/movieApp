//
//  MovieAppNetworkManager.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//


import Foundation
import ObjectMapper
import Alamofire
import UIKit

private let apiKey = "34a32d3e507790226a6a37712e3a5645"

extension NetworkManager {
    
    func getMovies(
        loadLocally: Bool = false,
        viewcontroller : UIViewController = UIViewController(),
        success : @escaping (MoviesModel) -> Void,
        failure : @escaping (NSError) -> Void)  {
            if loadLocally{
                let value = self.loadFromLocalFile(fileName: "HomeSceen")
                success(Mapper<MoviesModel>().map(JSON: value as! [String : Any])!)
                return
            }
            self.request(url: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)", method: .get,viewcontroller: viewcontroller) { (response) in
                if response.response?.statusCode == 200 {
                    do{
                        let value = try response.result.get()
                        success(Mapper<MoviesModel>().map(JSON: value as! [String : Any])!)
                        
                    }catch{
                        failure(NSError())
                    }
                }else{
                    failure(NSError())
                }
            }
        }
    
    func getMoviesBySearch(
        loadLocally: Bool = false,
        searchText : String,
        viewcontroller : UIViewController = UIViewController(),
        success : @escaping (MoviesModel) -> Void,
        failure : @escaping (NSError) -> Void)  {
            if loadLocally{
                let value = self.loadFromLocalFile(fileName: "HomeSceen")
                success(Mapper<MoviesModel>().map(JSON: value as! [String : Any])!)
                return
            }
            self.request(url: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(searchText)&page=1", method: .get,viewcontroller: viewcontroller) { (response) in
                if response.response?.statusCode == 200 {
                    do{
                        let value = try response.result.get()
                        success(Mapper<MoviesModel>().map(JSON: value as! [String : Any])!)
                        
                    }catch{
                        failure(NSError())
                    }
                }else{
                    failure(NSError())
                }
            }
        }
    
    func loadFromLocalFile(fileName : String) -> Any{
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                return jsonResult
                    
              } catch {
                   // handle error
              }
        }
        return "nil"
    }
    
}
