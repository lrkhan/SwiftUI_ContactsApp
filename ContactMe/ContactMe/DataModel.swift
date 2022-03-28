//
//  DataModel.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/28/22.
//

import Foundation
import SwiftUI


class Person: Codable, ObservableObject, Identifiable {
    var id = UUID()
    @Published var name: [String]
    @Published var phoneNumber: String
    @Published var email: String
    @Published var profilePic: String = ""
    
    init (name: [String], phoneNumber: String, email: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    func getImage() -> Image {
        if profilePic.isEmpty {
            return Image(systemName: "person").resizable()
        } else {
            return Image(profilePic).resizable()
        }
    }
    
    enum CodingKeys: CodingKey {
        case id, name, phoneNumber, email, profilePic
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(email, forKey: .email)
        try container.encode(profilePic, forKey: .profilePic)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode([String].self, forKey: .name)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.email = try container.decode(String.self, forKey: .email)
        self.profilePic = try container.decode(String.self, forKey: .profilePic)
    }
    
}

class Contacts: Codable, ObservableObject {
    @Published var peopleList: [Person]
    
    init() {
        peopleList = []
    }
    
    enum CodingKeys: CodingKey {
        case peopleList
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(peopleList, forKey: .peopleList)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.peopleList = try container.decode([Person].self, forKey: .peopleList)
    }
    
    var tempData: [Person] = [
        Person(name: ["Jone", "Doe"], phoneNumber: "12342334", email: "213234234"),
        Person(name: ["Jne", "Do"], phoneNumber: "12342334", email: "213234234"),
        Person(name: ["Joe", "De"], phoneNumber: "12342334", email: "213234234"),
        Person(name: ["elt", "Oe"], phoneNumber: "12342334", email: "213234234"),
        Person(name: ["Jede", "Poe"], phoneNumber: "12342334", email: "213234234")
    ]
    
    func updateContact(id: UUID, newInfo: Person) {
        for person in peopleList {
            if person.id == id {
                person.name = newInfo.name
                person.phoneNumber = newInfo.phoneNumber
                person.email = newInfo.email
                person.profilePic = newInfo.profilePic
                
                print("User Found and Updated")
                
                return
            }
        }
        
        print("user not found")
    }
}

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which should to be the only one
    return paths[0]
}


func loadContacts() -> Contacts {
    do {
        let fileURL = try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("userData.json")
        
        let data = try Data(contentsOf: fileURL)
        let userData = try JSONDecoder().decode(Contacts.self, from: data)
        
        print("Loaded User Successfully")
        
        return userData
    } catch {
        print("error reading user data")
        print(error)
        
        let usr = Contacts()
        saveContacts(usr)
        
        return Contacts()
    }
}

func saveContacts(_ user: Contacts) {
    do {
        let fileURL = try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("userData.json")
        
        try JSONEncoder()
            .encode(user)
            .write(to: fileURL)
        
        print("Writing complete")
        
        return
    } catch {
        print("error writing user data")
        
        return
    }
}

