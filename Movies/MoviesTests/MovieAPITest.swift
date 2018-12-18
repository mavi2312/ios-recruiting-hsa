//
//  MovieAPITest.swift
//  MoviesTests
//
//  Created by Consultor on 12/18/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import XCTest
@testable import Movies

class MovieAPITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetGenres(){
        let expectation = XCTestExpectation(description: "Download Genres")
        
        let locale = NSLocale.current.languageCode
        let networkManager = NetworkAPIManager()
        let paramsGenres = ["api_key":networkManager.apiKey,"language":locale ?? "es-US"] as [String : Any]
        
        networkManager.request(urlString: "genre/movie/list", params: paramsGenres){
            (response: GenresResponse?, error: ErrorTypes?) in
            if error != nil {
                XCTFail()
            } else {
                if let genres = response?.genres {
                    XCTAssert(genres.count > 0)
                } else {
                    XCTFail()
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testGetMovies(){
        let expectation = XCTestExpectation(description: "Download popular Movies")
        
        let locale = NSLocale.current.languageCode
        let networkManager = NetworkAPIManager()
        let paramsMovies = ["api_key":networkManager.apiKey,"page":1,"language":locale ?? "en-US"] as [String : Any]
        
        networkManager.request(urlString: "movie/popular", params: paramsMovies){
            (response: GenericPagedMovieResponse?, error: ErrorTypes?) in
            if error != nil {
                XCTFail()
            } else {
                if let movies = response?.results {
                    XCTAssert(movies.count > 0)
                } else {
                    XCTFail()
                }
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }

}
