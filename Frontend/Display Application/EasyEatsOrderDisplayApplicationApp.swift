//
//  EasyEatsOrderDisplayApplicationApp.swift
//  EasyEatsOrderDisplayApplication
//
//  Created by NaYu on 2023/04/09.
//

import SwiftUI
import FirebaseCore

@main
struct EasyEatsOrderDisplayApplicationApp: App {
    init () {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
