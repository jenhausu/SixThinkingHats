//
//  ContentView.swift
//  SixThinkingHats
//
//  Created by 蘇健豪 on 2021/7/29.
//

import SwiftUI

struct ContentView: View {
    
    @State var participants: [Participant] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(participants) { participant in
                        ParticipantRow(userName: participant.name,
                                       hat: participant.hats.last)
                    }
                }
                Button("分配") {
                    
                }
                .padding()
                Divider()
                Button("新討論") {
                    
                }
                .padding()
                Divider()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        add()
                    }
                }
            }
            .navigationTitle("六頂思考帽")
        }
    }
    
    func add() {
        participants.append(Participant(name: ""))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
