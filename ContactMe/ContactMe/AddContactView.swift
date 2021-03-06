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
    
    @State var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImgPicker = false
    
    @State private var alertToggle: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showingImgPicker = true
                    }){
                        ProfilePictureView(img: $image, person: .constant(janeDoeTemp))
                    }
                    .onChange(of: inputImage){ _ in loadImage()}
                    
                    Spacer()
                }
                .padding()
                
                Form{
                    Section("Name"){
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                    }
                    
                    Section("Email"){
                        TextField("Email Address", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section("Phone"){
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
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
                .alert("All Fields Must Be Filled Correctly", isPresented: $alertToggle) {
                    Button("OK", role: .cancel) { }
                }
                .sheet(isPresented: $showingImgPicker) {
                    ImagePicker(image: $inputImage)
                }
            }
        }
    }
    
    func addUser() {
        let newUser = Person(name: [firstName, lastName], phoneNumber: phoneNumber, email: email)
        
        if let userImg = inputImage {
            newUser.profilePic = saveImage(userImg, id: newUser.id)
        }
        
        contactList.peopleList.append(newUser)
        
        saveContacts(contactList)
    }
    
    func resetVars() {
        firstName = ""
        lastName  = ""
        email = ""
        phoneNumber = ""
    }
    
    func hasValues() -> Bool {
        return (!firstName.isEmpty && !lastName.isEmpty && (!email.isEmpty && checkIfValidEmail(input: email)) && !phoneNumber.isEmpty)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
