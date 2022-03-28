//
//  AddContactView.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/28/22.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var contactList: Contacts
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @State private var alertToggle: Bool = false
    
    var body: some View {
        NavigationView {
            Form{
                
                Section("Name"){
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                
                Section("Email"){
                    TextField("Email Address", text: $email)
                }
                
                Section("Phone"){
                    TextField("Phone Number", text: $phoneNumber)
                }
            }
            
                .navigationTitle("Add New Contact")
                .toolbar{
                    ToolbarItemGroup{
                        Button(action:{
                            dismiss()
                        }){
                            Text("Cancel")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
                        }
                    }
                    ToolbarItemGroup(placement: .bottomBar){
                        Button(action:{
                            if hasValues() {
                                addUser()
                                
                                resetVars()
                                
                                dismiss()
                            } else {
                                alertToggle.toggle()
                            }
                        }){
                            Text("Add User")
                        }
                    }
                }
                .alert("All Fields Must Be Filled", isPresented: $alertToggle) {
                            Button("OK", role: .cancel) { }
                        }
        }
    }
    
    func addUser() {
        contactList.peopleList.append(Person(name: [firstName, lastName], phoneNumber: phoneNumber, email: email))
        
        saveContacts(contactList)
    }
    
    func resetVars() {
        firstName = ""
        lastName  = ""
        email = ""
        phoneNumber = ""
    }
    
    func hasValues() -> Bool {
        return (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !phoneNumber.isEmpty)
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
