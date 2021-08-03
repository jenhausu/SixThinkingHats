//
//  ParticipantRow.swift
//  ParticipantRow
//
//  Created by 蘇健豪 on 2021/8/3.
//

import SwiftUI

struct ParticipantRow: View {
    @State var userName: String
    @State var hat: Hat?
    
    var body: some View {
        HStack {
            TextField("請輸入參加者姓名", text: $userName)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
            if let hat = hat {
                Text("\(displayHat(hat))帽子")
            }
        }.padding()
    }
    
    func displayHat(_ hat: Hat) -> String {
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
    
}

struct ParticipantRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParticipantRow(userName: "")
            ParticipantRow(userName: "參加者姓名")
            ParticipantRow(userName: "參加者姓名", hat: .white)
        }
    }
}
