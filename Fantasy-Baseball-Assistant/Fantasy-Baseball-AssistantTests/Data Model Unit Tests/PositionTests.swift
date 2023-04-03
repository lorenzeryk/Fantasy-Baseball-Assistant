//
//  PositionTests.swift
//  Fantasy-Baseball-AssistantTests
//
//  Created by Eryk Lorenz on 4/3/23.
//

import XCTest

final class PositionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAbbreviation() {
        XCTAssertEqual(PlayerPosition.Center.abbreviation, "CF", "Center field abbreviation failed")
        XCTAssertEqual(PlayerPosition.SP.abbreviation, "SP", "Starting pitcher abbreviation failed")
    }
    
    func testFullText() {
        XCTAssertEqual(PlayerPosition.Right.fullText, "Right Field", "Right field full text failed")
        XCTAssertEqual(PlayerPosition.Short.fullText, "Shortstop", "Shortstop full text failed")
    }

}
