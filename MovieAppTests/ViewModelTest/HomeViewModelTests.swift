//
//  HomeViewModel.swift
//  MovieAppTests
//
//  Created by Ruman on 15/05/2022.
//

import Foundation
import XCTest
@testable import MovieApp

class HomeViewModelTests: XCTestCase{

    var viewModel : MovieHomeViewModel!
    let exception = XCTestExpectation.init(description: "Exception")
    override func setUp() {
        super.setUp()
        viewModel =  MovieHomeViewModel(delegate: self)
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
    
    func test_get_cache() throws{
        let obj = viewModel.getFromCash()
        XCTAssertNotNil(obj)
    }
}

extension HomeViewModelTests: MovieHomeProtocols {
    func movieDataProvider(_ movieData: [MovieResultsArray]) {
        self.testData(movieData: movieData)
        exception.fulfill()
    }
    
    func showError(errorDesc: String) {
        exception.fulfill()
        self.testShowError(errorDesc: errorDesc)
    }
    
}
