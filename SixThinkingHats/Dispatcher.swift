//
//  Dispatcher.swift
//  SixThinkingHats
//
//  Created by 蘇健豪 on 2021/7/29.
//

import Foundation

class Participant {
    let name: String
    let hats: [Hat] = []
    
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
    
}
