//
//  ParticipantRow.swift
//  ParticipantRow
//
//  Created by 蘇健豪 on 2021/8/3.
//

import SwiftUI

struct ParticipantRow: View {
    
    @ObservedObject var user: Participant
    
    var body: some View {
        HStack {
            TextField("請輸入參加者姓名", text: $user.name)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
            if let hat = user.hats.last {
                HStack {
                    displayHatColor(hat)
                        .frame(width: 20, height: 20)
                        .background(displayHatColor(hat))
                        .border(.gray, width: 1)
                    Text("\(displayHatName(hat))帽子")
                        .foregroundColor(displayHatColor(hat))
                }
            }
        }
        .padding()
    }
    
    func displayHatName(_ hat: Hat) -> String {
        switch hat {
        case .white:
            return "白"
        case .red:
            return "紅"
        case .black:
            return "黑"
        case .yellow:
            return "黃"
        case .green:
            return "綠"
        case .blue:
            return "藍"
        }
    }
    
    func displayHatColor(_ hat: Hat) -> Color {
        Color(hat.rawValue)
    }
    
}

struct ParticipantRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ParticipantRow(user: Participant(name: "", hats: [.white]))
            ParticipantRow(user: Participant(name: "", hats: [.yellow]))
            ParticipantRow(user: Participant(name: "", hats: [.red]))
            ParticipantRow(user: Participant(name: "", hats: [.blue]))
            ParticipantRow(user: Participant(name: "", hats: [.black]))
            ParticipantRow(user: Participant(name: "", hats: [.green]))
        }
    }
}
