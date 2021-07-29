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
    
    // MARK: - Helper
    
    func makeSUT() -> Dispatcher {
        Dispatcher()
    }
    
}
