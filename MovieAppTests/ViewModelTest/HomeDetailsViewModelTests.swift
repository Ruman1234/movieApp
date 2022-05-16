//
//  HomeDetailsViewModelTests.swift
//  MovieAppTests
//
//  Created by Ruman on 15/05/2022.
//

import Foundation
import XCTest
@testable import MovieApp

class HomeDetailsViewModelTests: XCTestCase{
    
    var viewModel : MovieDetailsDelegate!
    let exception = XCTestExpectation.init(description: "Exception")
    override func setUp() {
        super.setUp()
        viewModel =  MovieDetailsViewModel(delegate: self)
        
        let movie = MovieResultsArray(moviePoster:  "", movieName:  "", releaseDate: "", backdrop_path: "",favorite: false, overview: "")

        viewModel.addRemoveMovieFromDB(isAdd: false, data: movie)
        self.wait(for: [exception], timeout: 30)
    }
    
    override class func tearDown() {
        super.tearDown()
//        viewModel = nil
    }
    
    func test_remove_from_VM(res: Bool)  {
        XCTAssertNotNil(res)
    }
}

extension HomeDetailsViewModelTests: MovieDetailsViewModelDelegate{
    func removeFromFavItmes(res: Bool) {
        self.test_remove_from_VM(res: res)
    }
}
    
