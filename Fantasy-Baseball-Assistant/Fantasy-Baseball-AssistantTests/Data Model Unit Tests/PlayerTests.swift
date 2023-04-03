//
//  PlayerTests.swift
//  Fantasy-Baseball-AssistantTests
//
//  Created by Eryk Lorenz on 4/3/23.
//

import XCTest

final class PlayerTests: XCTestCase {
    var testPlayer: Player = Player(first_name: "Test", last_name: "Player", team: Team.Angels)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsPitcher() {
        testPlayer.primary_position = PlayerPosition.SP
        XCTAssertTrue(testPlayer.isPitcher(), "Returned false for starting pitcher")
        
        testPlayer.primary_position = PlayerPosition.RP
        XCTAssertTrue(testPlayer.isPitcher(), "Returned false for relief pitcher")
        
        testPlayer.primary_position = PlayerPosition.C
        XCTAssertFalse(testPlayer.isPitcher(), "Returned true for catcher")
    }

}
