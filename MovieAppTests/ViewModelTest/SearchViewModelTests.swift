//
//  SearchViewModelTests.swift
//  MovieAppTests
//
//  Created by Ruman on 15/05/2022.
//


import Foundation
import XCTest
@testable import MovieApp

class SearchViewModelTests: XCTestCase{

    var viewModel : SearchMovieViewProtocol!
    let exception = XCTestExpectation.init(description: "Exception")
    override func setUp() {
        super.setUp()
        viewModel =  SearchMovieViewModel(delegate: self)
        viewModel.saveSearchesToDB(str: "a")
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

extension SearchViewModelTests: MovieHomeProtocols{
    func movieDataProvider(_ movieData: [MovieResultsArray]) {
        self.testData(movieData: movieData)
        exception.fulfill()
    }
    
    func showError(errorDesc: String) {
        exception.fulfill()
        self.testShowError(errorDesc: errorDesc)
    }
}
