//
//  ContactView.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/28/22.
//

import SwiftUI

struct ContactView: View {
    @EnvironmentObject var contactList: Contacts
    
    @State var personInfo: Person
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @State private var isEditing = false
    
    var body: some View {
        Group {
            if isEditing {
                Form{
                    
                    Section("Name"){
                        TextField("\(personInfo.name[0])", text: $firstName)
                        TextField("\(personInfo.name[1])", text: $lastName)
                    }
                    
                    Section("Email"){
                        TextField("\(personInfo.email)", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section("Phone"){
                        TextField("\(personInfo.phoneNumber)", text: $phoneNumber)
                            .keyboardType(.phonePad)
                    }
                    
                }
                
                    .navigationTitle("Edit Contact")
            } else {
                Form{
                    Section("Phone Number"){
                        Text(personInfo.phoneNumber)
                    }
                    
                    Section("Email"){
                        Text(personInfo.email)
                    }
                }
                
                .navigationTitle("\(personInfo.name[0]) \(personInfo.name[1])")
            }
        }
        .toolbar{
            ToolbarItemGroup{
                if isEditing {
                    Button(action:{
                        
                        let newUpdates = Person(
                            name: [firstName.isEmpty ? personInfo.name[0]: firstName, lastName.isEmpty ? personInfo.name[1]: lastName],
                            phoneNumber: phoneNumber.isEmpty ? personInfo.phoneNumber : phoneNumber,
                            email: (email.isEmpty && !checkIfValidEmail(input: email)) ? personInfo.email: email)
                        
                        contactList.updateContact(id: personInfo.id, newInfo: newUpdates)
                        
                        resetVars()
                        
                        saveContacts(contactList)
                        
                        isEditing.toggle()
                    }){
                        Text("Done")
                            .padding()
                    }
                } else {
                    Button(action:{
                        isEditing.toggle()
                    }){
                        Text("Edit")
                            .padding()
                    }
                }
            }
        }
    }
    func resetVars() {
        firstName = ""
        lastName  = ""
        email = ""
        phoneNumber = ""
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactView(personInfo: Person(name: ["Jane","Doe"], phoneNumber: "31331313", email: "sflkjlkj@apple.com"))
        }
    }
}
