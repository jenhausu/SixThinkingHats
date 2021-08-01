//
//  DispatcherTests.swift
//  SixThinkingHatsTests
//
//  Created by 蘇健豪 on 2021/7/29.
//

import XCTest
@testable import SixThinkingHats

class DispatcherTests: XCTestCase {
    
    // MARK: - Participant
    
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
    
    // MARK: - Dispatch Once
    
    func testDispatcher_lessThan6_success() {
        dispatchTest(userCount: 5) { countArray in
            XCTAssertEqual(countArray[0], 5)
        }
    }
    
    func testDispatcher_dividable6_success() {
        dispatchTest(userCount: 6) { countArray in
            XCTAssertEqual(countArray[0], 6)
        }
    }
    
    func testDispatcher_dividable12_success() {
        dispatchTest(userCount: 12) { countArray in
            XCTAssertEqual(countArray[1], 6)
        }
    }
    
    func testDispatcher_remainder1_success() {
        dispatchTest(userCount: 7) { countArray in
            XCTAssertEqual(countArray[0], 5)
            XCTAssertEqual(countArray[1], 1)
        }
    }
    
    func testDispatcher_remainder2_success() {
        dispatchTest(userCount: 8) { countArray in
            XCTAssertEqual(countArray[0], 4)
            XCTAssertEqual(countArray[1], 2)
        }
    }
    
    func testDispatcher_remainder3_success() {
        dispatchTest(userCount: 9) { countArray in
            XCTAssertEqual(countArray[0], 3)
            XCTAssertEqual(countArray[1], 3)
        }
    }
    
    func testDispatcher_remainder4_success() {
        dispatchTest(userCount: 10) { countArray in
            XCTAssertEqual(countArray[0], 2)
            XCTAssertEqual(countArray[1], 4)
        }
    }
    
    func testDispatcher_remainder5_success() {
        dispatchTest(userCount: 11) { countArray in
            XCTAssertEqual(countArray[0], 1)
            XCTAssertEqual(countArray[1], 5)
        }
    }
    
    // MARK: - Dispatch more than once
    
    func test_dispatch_threeTimes_notDuplicate() {
        let sut = makeSUT()
        for index in 0..<6 {
            sut.addParticipant(name: "user\(index)")
        }
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        
        for user in sut.participants {
            let setObject = Set(user.hats)
            XCTAssertEqual(setObject.count, 3)
        }
    }
    
    func test_dispatch_fourTimes_notDuplicate() {
        let sut = makeSUT()
        for index in 0..<6 {
            sut.addParticipant(name: "user\(index)")
        }
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        
        for user in sut.participants {
            let setObject = Set(user.hats)
            XCTAssertEqual(setObject.count, 4)
        }
    }
    
    func test_dispatch_fourTimes_performance() {
        measure {
            let sut = makeSUT()
            for index in 0..<6 {
                sut.addParticipant(name: "user\(index)")
            }
            sut.dispatch()
            sut.dispatch()
            sut.dispatch()
            sut.dispatch()
            
            for user in sut.participants {
                let setObject = Set(user.hats)
                XCTAssertEqual(setObject.count, 4)
            }
        }
    }
    
    func test_dispatch_fiveTimes_notDuplicate() {
        let sut = makeSUT()
        for index in 0..<6 {
            sut.addParticipant(name: "user\(index)")
        }
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()

        for user in sut.participants {
            let setObject = Set(user.hats)
            XCTAssertEqual(setObject.count, 5)
        }
    }
    
    func test_dispatch_sixTimes_notDuplicate() {
        let sut = makeSUT()
        for index in 0..<6 {
            sut.addParticipant(name: "user\(index)")
        }
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        
        for user in sut.participants {
            let setObject = Set(user.hats)
            XCTAssertEqual(setObject.count, 6)
        }
    }
    
    func test_dispatch_sevenPeople_threeTimes_notDuplicate() {
        let sut = makeSUT()
        for index in 0..<7 {
            sut.addParticipant(name: "user\(index)")
        }
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        
        for user in sut.participants {
            let setObject = Set(user.hats)
            XCTAssertEqual(setObject.count, 3)
        }
    }
    
    func test_dispatch_eightPeople_threeTimes_notDuplicate() {
        let sut = makeSUT()
        for index in 0..<8 {
            sut.addParticipant(name: "user\(index)")
        }
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        sut.dispatch()
        
        for user in sut.participants {
            let setObject = Set(user.hats)
            XCTAssertEqual(setObject.count, 4)
        }
    }
    
    // MARK: - checkIsAllRemainHatsCantDispatch

    func test_checkIsAllRemainHatsCantDispatch_contain_true() {
        let sut = makeSUT()
        let user = Participant(name: "userName")
        user.hats.append(.white)
        user.hats.append(.red)

        let result = sut.checkIsAllRemainHatsCantDispatch(user: user,
                                                          remainHats: [.red])
        
        XCTAssertEqual(result, true)
    }
    
    func test_checkIsAllRemainHatsCantDispatch_partialContain_false() {
        let sut = makeSUT()
        let user = Participant(name: "userName")
        user.hats.append(.white)
        user.hats.append(.red)
        
        let result = sut.checkIsAllRemainHatsCantDispatch(user: user,
                                                          remainHats: [.red, .blue])
        
        XCTAssertEqual(result, false)
    }
    
    func test_checkIsAllRemainHatsCantDispatch_allNotContain_false() {
        let sut = makeSUT()
        let user = Participant(name: "userName")
        user.hats.append(.white)
        user.hats.append(.red)
        
        let result = sut.checkIsAllRemainHatsCantDispatch(user: user,
                                                          remainHats: [.blue, .black])
        
        XCTAssertEqual(result, false)
    }
    
    // MARK: - clearThisDispatch
    
    func test_clearThisDispatch() {
        
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
