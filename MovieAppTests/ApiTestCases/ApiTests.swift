//
//  ApiTests.swift
//  MovieAppTests
//
//  Created by Ruman on 15/05/2022.
//

import Foundation
import XCTest
@testable import MovieApp

class ApiTests: XCTestCase {

    func test_home_api_call_live_serve(){
        let exception = XCTestExpectation.init(description: "Exception")
        NetworkManager.SharedInstance.getMovies { res in
            XCTAssertEqual(res.page, 1)
            exception.fulfill()
        } failure: { err in
            
        }
        self.wait(for: [exception], timeout: 30)
    }
    
    func test_search_api_call_live_serve(){
        let exception = XCTestExpectation.init(description: "Exception")
        NetworkManager.SharedInstance.getMoviesBySearch(searchText: "q") { res in
            XCTAssertEqual(res.page, 1)
            exception.fulfill()
        } failure: { err in
            
        }
        self.wait(for: [exception], timeout: 30)
    }
    
    func test_home_api_call_locally(){
        let exception = XCTestExpectation.init(description: "Exception")
        NetworkManager.SharedInstance.getMovies(loadLocally: true, success: { res in
            XCTAssertEqual(res.results?.count, 20)
            exception.fulfill()
        }) { err in
            
        }
        self.wait(for: [exception], timeout: 30)
    }
    
    func test_search_api_call_locally(){
        let exception = XCTestExpectation.init(description: "Exception")
        NetworkManager.SharedInstance.getMoviesBySearch(loadLocally: true,searchText: "asd", success: { res in
            XCTAssertEqual(res.results?.count, 20)
            exception.fulfill()
        }) { err in
            
        }
        self.wait(for: [exception], timeout: 30)
    }
    
}
