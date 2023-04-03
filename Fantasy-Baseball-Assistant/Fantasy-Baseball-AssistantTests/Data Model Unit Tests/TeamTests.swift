//
//  TeamTests.swift
//  Fantasy-Baseball-AssistantTests
//
//  Created by Eryk Lorenz on 4/3/23.
//

import XCTest

final class TeamTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAbbreviation() {
        XCTAssertEqual(Team.Rockies.abbreviation, "COL", "Rockies abbreviation failed")
        XCTAssertEqual(Team.Rays.abbreviation, "TB", "Rays abbreviation failed")
    }
    
    func testFullText() {
        XCTAssertEqual(Team.Dodgers.fullText, "Los Angeles Dodgers", "Dodgers full text failed")
        XCTAssertEqual(Team.Athletics.fullText, "Oakland Athletics", "Athletics full text failed")
    }

}
