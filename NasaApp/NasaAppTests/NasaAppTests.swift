//
//  NasaAppTests.swift
//  NasaAppTests
//
//  Created by Anshuman Dahale on 16/10/22.
//

import XCTest

class NasaAppTests: XCTestCase {
    
    func testThatThereExistsAFiledataJsonInAppBundle() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            XCTAssertNotNil(path)
        }
    }
}
