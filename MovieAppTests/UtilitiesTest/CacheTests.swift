//
//  CacheTests.swift
//  MovieAppTests
//
//  Created by Ruman on 15/05/2022.
//

import XCTest
@testable import MovieApp

class CacheTests: XCTestCase {
    
    func test_push_to_cache() throws {
        MRCacheManager.sharedManager.pushToCache(Model: "tesstObj" as AnyObject)
        let count = MRCacheManager.sharedManager.cacheCount
        XCTAssertNotEqual(count, 0)
    }
    
    func test_push_to_cache_fail() throws {
        MRCacheManager.sharedManager.pushToCache(Model: "tesstObj" as AnyObject)
        let count = MRCacheManager.sharedManager.cacheCount
        XCTAssertEqual(count, 0)
    }
    
    func test_push_to_cache_with_key() throws {
        MRCacheManager.sharedManager.pushToCache(Model: "tesstObj" as AnyObject,modelType: "test")
        let count = MRCacheManager.sharedManager.cacheCount
        XCTAssertNotEqual(count, 0)
    }
    
    func test_push_to_cache_with_key_fail() throws {
        MRCacheManager.sharedManager.pushToCache(Model: "tesstObj" as AnyObject,modelType: "test")
        let count = MRCacheManager.sharedManager.cacheCount
        XCTAssertEqual(count, 0)
    }
    
    func test_push_to_cache_with_type() throws {
        MRCacheManager.sharedManager.pushToCache(Value: "tesstObj" as AnyObject, Key: "test", type: .cache)
        let count = MRCacheManager.sharedManager.cacheCount
        XCTAssertNotEqual(count, 0)
    }
    
    func test_push_to_cache_with_type_fail() throws {
        MRCacheManager.sharedManager.pushToCache(Value: "tesstObj" as AnyObject, Key: "test", type: .cache)
        let count = MRCacheManager.sharedManager.cacheCount
        XCTAssertEqual(count, 0)
    }
    
    func test_pull_from_cache() throws {
        let obj = MRCacheManager.sharedManager.pullFromCache(Model: "test" as AnyObject)
        XCTAssertNotNil(obj)
    }

    func test_pull_from_cache_fail() throws {
        let obj = MRCacheManager.sharedManager.pullFromCache(Model: "tesstObj" as AnyObject)
        XCTAssertNil(obj)
    }

    func test_pull_from_cache_with_key() throws {
        let obj = MRCacheManager.sharedManager.pullFromCache(Model: "tesstObj" as AnyObject,modelType: "test")
        XCTAssertNotNil(obj)
    }

    func test_pull_from_cache_with_key_fail() throws {
        let obj = MRCacheManager.sharedManager.pullFromCache(Model: "tesstObj" as AnyObject,modelType: "test")
        XCTAssertNil(obj)
    }

    func test_pull_from_cache_with_type() throws {
        let obj = MRCacheManager.sharedManager.pullFromCache(Key: "test", type: .cache)
        XCTAssertNotNil(obj)
    }

    func test_pull_from_cache_with_type_fail() throws {
        let obj = MRCacheManager.sharedManager.pullFromCache(Key: "test", type: .cache)
        XCTAssertNil(obj)
    }

    func test_push_to_local() throws {
        let val = MRCacheManager.sharedManager.pushToCache(Value: ["test"] as AnyObject, Key: "testKey", type: .local)
        XCTAssertEqual(val as! [String], ["test"])
    }

    func test_pull_to_local() throws {
        let val = MRCacheManager.sharedManager.pullFromCache(Key: "testKey", type: .local)
        XCTAssertEqual(val as! [String], ["test"])
    }
    
    func test_push_to_local_fail() throws {
        let val = MRCacheManager.sharedManager.pushToCache(Value: ["test"] as AnyObject, Key: "testKey", type: .local)
        XCTAssertEqual(val as! [String], ["test123"])
    }

}
    
