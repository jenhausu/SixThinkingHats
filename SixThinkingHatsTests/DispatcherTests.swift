//
//  DispatcherTests.swift
//  SixThinkingHatsTests
//
//  Created by 蘇健豪 on 2021/7/29.
//

import XCTest
@testable import SixThinkingHats

class DispatcherTests: XCTestCase {
    
    func testDispatcher_addParticipant_countOne() {
        let sut = makeSUT()
        sut.addParticipant(name: "new user")
        
        XCTAssertEqual(sut.participants.count, 1)
    }
    
    func testDispatcher_removeAllParticipant_success() {
        let sut = makeSUT()
        sut.addParticipant(name: "new user")
        sut.removeAllParticipants()
        
        XCTAssertEqual(sut.participants.count, 0)
    }
    
    func testDispatcher_dispatch6User_success() {
        let sut = makeSUT()
        sut.addParticipant(name: "user1")
        sut.addParticipant(name: "user2")
        sut.addParticipant(name: "user3")
        sut.addParticipant(name: "user4")
        sut.addParticipant(name: "user5")
        sut.addParticipant(name: "user6")
        sut.dispatch()
        
        var dispatchedHats: [Hat: Int] = [:]
        for user in sut.participants {
            guard let hat = user.currentHat else { continue }
            if dispatchedHats[hat] != nil {
                dispatchedHats[hat]! += 1
            } else {
                dispatchedHats[hat] = 1
            }
        }
        
        XCTAssertEqual(dispatchedHats[.white], 1)
        XCTAssertEqual(dispatchedHats[.red], 1)
        XCTAssertEqual(dispatchedHats[.black], 1)
        XCTAssertEqual(dispatchedHats[.yellow], 1)
        XCTAssertEqual(dispatchedHats[.green], 1)
        XCTAssertEqual(dispatchedHats[.black], 1)
    }
    
    // MARK: - Helper
    
    func makeSUT() -> Dispatcher {
        Dispatcher()
    }
    
}
