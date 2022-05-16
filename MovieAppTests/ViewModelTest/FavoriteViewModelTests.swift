//
//  FavoriteViewModel.swift
//  MovieAppTests
//
//  Created by Ruman on 15/05/2022.
//

import Foundation
import XCTest
@testable import MovieApp

class FavoriteViewModelTests: XCTestCase{

    var viewModel : MoviesDataManabable!
    let exception = XCTestExpectation.init(description: "Exception")
    override func setUp() {
        super.setUp()
        viewModel =  FavoriteeViewModel(delegate: self)
        viewModel?.getMoviesData()
        self.wait(for: [exception], timeout: 30)
    }
    
    override class func tearDown() {
        super.tearDown()
//        viewModel = nil
    }
    
    func testData(movieData: [MovieResultsArray]){
        XCTAssertNotNil(movieData)
    }
    func testShowError(errorDesc: String){
        XCTAssertNotNil(errorDesc)
    }
}

extension FavoriteViewModelTests: MovieHomeProtocols {
    func movieDataProvider(_ movieData: [MovieResultsArray]) {
        self.testData(movieData: movieData)
        exception.fulfill()
    }
    
    func showError(errorDesc: String) {
        exception.fulfill()
        self.testShowError(errorDesc: errorDesc)
    }
    
}
