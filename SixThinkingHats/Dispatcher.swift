//
//  Dispatcher.swift
//  SixThinkingHats
//
//  Created by 蘇健豪 on 2021/7/29.
//

import Foundation

class Participant {
    let name: String
    var hats: [Hat] = []
    
    var currentHat: Hat? {
        hats.last
    }
    
    init(name: String) {
        self.name = name
    }
}

class Dispatcher {
    
    var participants: [Participant] = []
    
    func addParticipant(name: String) {
        participants.append(Participant(name: name))
    }
    
    func removeAllParticipants() {
        participants.removeAll()
    }
    
    func dispatch() {
        var notDispatchedHats = Hat.allCases
        
        for user in participants {
            let index = Int.random(in: 0...notDispatchedHats.count - 1)
            let hat = notDispatchedHats[index]
            user.hats.append(hat)
            notDispatchedHats.remove(at: index)
        }
    }
    
}
