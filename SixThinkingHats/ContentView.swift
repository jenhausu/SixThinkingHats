//
//  ContentView.swift
//  SixThinkingHats
//
//  Created by 蘇健豪 on 2021/7/29.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: Dispatcher
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(model.participants) { participant in
                        ParticipantRow(user: participant)
                    }
                    .onDelete(perform: delete)
                }
                Button("分配") {
                    model.dispatch()
                }
                .padding()
                Divider()
                Button("新討論") {
                    model.restart()
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
        model.addParticipant(name: "")
    }
    
    func delete(at offsets: IndexSet) {
        model.participants.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Dispatcher())
    }
}
