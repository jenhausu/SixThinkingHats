//
//  SixThinkingHatsApp.swift
//  SixThinkingHats
//
//  Created by 蘇健豪 on 2021/7/29.
//

import SwiftUI

@main
struct SixThinkingHatsApp: App {
    
    @StateObject var model = Dispatcher()
        
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
