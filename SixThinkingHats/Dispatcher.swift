//
//  Dispatcher.swift
//  SixThinkingHats
//
//  Created by 蘇健豪 on 2021/7/29.
//

import Foundation
import SwiftUI

class Participant: ObservableObject, Identifiable {
    var name: String
    @Published var hats: [Hat] = []
    
    var currentHat: Hat? {
        hats.last
    }
    
    init(name: String, hats: [Hat] = []) {
        self.name = name
        self.hats = hats
    }
}

class Dispatcher: ObservableObject {
    
    @Published var participants: [Participant] = []
    
    func addParticipant(name: String) {
        participants.append(Participant(name: name))
    }
    
    func removeAllParticipants() {
        participants.removeAll()
    }
    
    func dispatch() {
        var notDispatchedHats = makeNotDispatchedHats()
        
        for (index, user) in participants.enumerated() {
            guard user.hats.count != 6 else { continue }
            
            var hatIndex: Int
            var hat: Hat
            var dispatchCount = 0
            
            repeat {
                hatIndex = Int.random(in: 0...notDispatchedHats.count - 1)
                hat = notDispatchedHats[hatIndex]
                dispatchCount += 1
                
                if checkIsAllRemainHatsCantDispatch(user: user, remainHats: notDispatchedHats) {
                    clearThisDispatch(user: user, index: index)
                    dispatch()
                    return
                }
            } while user.hats.contains(hat)
            
            user.hats.append(hat)
            notDispatchedHats.remove(at: hatIndex)
        }
    }
    
    func restart() {
        for user in participants {
            user.hats = []
        }
    }
    
    func checkIsAllRemainHatsCantDispatch(user: Participant, remainHats: [Hat]) -> Bool {
        let currentHatSet = Set(user.hats)
        
        return Set(remainHats).isSubset(of: currentHatSet)
    }
    
    func clearThisDispatch(user: Participant, index: Int) {
        for userIndex in 0..<index {
            let user = participants[userIndex]
            user.hats.removeLast()
        }
    }
    
    private func makeNotDispatchedHats() -> [Hat] {
        var hats: [Hat] = []
        for _ in 0..<(participants.count / 6) {
            hats += Hat.allCases
        }
        
        var sixHats = Hat.allCases
        for _ in 0..<(participants.count % 6) {
            let index = Int.random(in: 0..<sixHats.count)
            hats.append(sixHats[index])
            sixHats.remove(at: index)
        }
        
        return hats
    }
    
}
