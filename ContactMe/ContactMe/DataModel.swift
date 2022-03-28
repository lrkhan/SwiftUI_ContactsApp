//
//  DataModel.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/28/22.
//

import Foundation
import SwiftUI


class Person: Codable {
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

class Contacts: Codable {
    @Published var peopleList: [Person] = []
    
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
}


