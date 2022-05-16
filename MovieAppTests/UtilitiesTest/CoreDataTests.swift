//
//  CoreDataTests.swift
//  MovieAppTests
//
//  Created by Ruman on 15/05/2022.
//

import XCTest
@testable import MovieApp

class CoreDataTests: XCTestCase {
    
    func test_save_to_coredata() throws {
        let movie = MovieLocalDBModel(moviePoster: "", movieName: "", releaseDate: "", favorite: true,backdrop_path: "", overview: "" )
       let val = CoreDataModel.shared.save_Create_Data(entityName: CoreDataConstants.entityName, key: CoreDataConstants.movie_Keys.movie.rawValue, value: movie)
        XCTAssertEqual(val, true)
    }
    
    func test_get_from_coredata() throws {
       let val = CoreDataModel.shared.getData(entityName: CoreDataConstants.entityName)
        XCTAssertNotNil(val)
    }
    
    func test_get_from_movieData() throws {
       let val = CoreDataModel.shared.getMovieData()
        XCTAssertNotNil(val)
    }
    
    func test_delete() throws {
       let val = CoreDataModel.shared.deleteAllData(entityName: CoreDataConstants.entityName)
        XCTAssertNotNil(val)
    }
}
