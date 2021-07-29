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
    
    func testDispatcher_dispatch5User_success() {
        dispatchTest(userCount: 5) { countArray in
            XCTAssertEqual(countArray[0], 5)
        }
    }
    
    func testDispatcher_dispatch6User_success() {
        dispatchTest(userCount: 6) { countArray in
            XCTAssertEqual(countArray[0], 6)
        }
    }
    
    func testDispatcher_dispatch7User_success() {
        dispatchTest(userCount: 7) { countArray in
            XCTAssertEqual(countArray[0], 5)
            XCTAssertEqual(countArray[1], 1)
        }
    }
    
    func testDispatcher_dispatch8User_success() {
        dispatchTest(userCount: 8) { countArray in
            XCTAssertEqual(countArray[0], 4)
            XCTAssertEqual(countArray[1], 2)
        }
    }
    
    func testDispatcher_dispatch11User_success() {
        dispatchTest(userCount: 11) { countArray in
            XCTAssertEqual(countArray[0], 1)
            XCTAssertEqual(countArray[1], 5)
        }
    }
    
    func testDispatcher_dispatch13User_success() {
        dispatchTest(userCount: 13) { countArray in
            XCTAssertEqual(countArray[0], 0)
            XCTAssertEqual(countArray[1], 5)
            XCTAssertEqual(countArray[2], 1)
        }
    }
    
    // MARK: - Helper
    
    func makeSUT() -> Dispatcher {
        Dispatcher()
    }
    
    func dispatchTest(userCount: Int, callback: ([Int]) -> Void) {
        let sut = makeSUT()
        for index in 0..<userCount {
            sut.addParticipant(name: "user\(index)")
        }
        
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
        
        var hatCount: [Int] = Array(repeating: 0, count: (userCount / 6) + 1)
        for (_, value) in dispatchedHats {
            hatCount[value - 1] += 1
        }
        
        callback(hatCount)
    }
    
}
