//
//  RosterTest.swift
//  Fantasy-Baseball-AssistantTests
//
//  Created by Eryk Lorenz on 4/3/23.
//

import XCTest

final class RosterTest: XCTestCase {
    var roster: Roster = Roster()

    override func setUpWithError() throws {
        roster = Roster(testData: true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPitcherList() throws {
        roster.updatePitchersHitters()
        
        XCTAssertEqual(roster.pitchers.count, 2, "List of pitchers is not the correct size")
        for pitcher in roster.pitchers {
            XCTAssert(pitcher.primary_position == PlayerPosition.SP || pitcher.primary_position == PlayerPosition.RP || pitcher.primary_position != PlayerPosition.None, "Non pitcher is present in list of pitchers")
        }
    }
    
    func testHitterList() throws {
        roster.updatePitchersHitters()
        
        XCTAssertEqual(roster.hitters.count, 2, "List of hitters is not the correct size")
        for hitter in roster.hitters {
            XCTAssert(hitter.primary_position != PlayerPosition.SP || hitter.primary_position == PlayerPosition.RP || hitter.primary_position != PlayerPosition.None, "Non hitter is present in list of hitters")
        }
    }
    
    func testGetPlayerByID() throws {
        let realID = roster.players[0].id
        let returnedPlayer = roster.getPlayerByID(playerID: [realID])
        
        XCTAssert(returnedPlayer != nil, "Did not return player")
        XCTAssert(returnedPlayer == roster.players[0], "Returned incorrect player")
        XCTAssert(returnedPlayer?.first_name == roster.players[0].first_name, "First name does not match")
        XCTAssert(returnedPlayer?.last_name == roster.players[0].last_name, "Last name does not match")
    }
    
    func testNonExistantPlayerByID() throws {
        let fakePlayerID = UUID()
        XCTAssert(roster.getPlayerByID(playerID: [fakePlayerID]) == nil, "Returned a non existant player")
    }
}
