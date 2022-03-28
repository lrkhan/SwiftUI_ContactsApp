//
//  ContactMeApp.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/28/22.
//

import SwiftUI

@main
struct ContactMeApp: App {
    @StateObject var appData: Contacts = loadContacts()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
        }
    }
}
