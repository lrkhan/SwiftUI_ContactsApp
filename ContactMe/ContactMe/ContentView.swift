//
//  ContentView.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/28/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var contactList: Contacts
    
    @State private var showAddSheet = false
    @State private var searchText = ""
    
//    @State private var isList = true
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(getSearchResults, id: \.id){ person in
                    NavigationLink("\(person.name[0]) \(person.name[1])", destination: ContactView(personInfo: person))
                }
                .onDelete(perform: delete)
            }
            
            .searchable(text: $searchText)
            .navigationTitle("Contacts")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showAddSheet.toggle()
                        }) {
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 20))
                                .padding()
                    }
                }
//                ToolbarItemGroup(placement: .navigationBarLeading){
//                    Button(action: {
//                        isList.toggle()
//                    }) {
//                        Image(systemName: isList ?  "square.grid.3x3.square" : "line.3.horizontal")
//                            .font(.system(size: 20))
//                            .padding()
//                    }
//                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddContactView()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for i in offsets {
            if let found = contactList.peopleList.firstIndex(where: { $0.id == getSearchResults[i].id }){
                contactList.peopleList.remove(at: found)
            }
        }
        
        //contactList.peopleList.remove(atOffsets: offsets)
    }
    
    var getSearchResults: [Person] {
        if searchText.isEmpty {
            return contactList.peopleList.sorted{
                $0.name[0] < $1.name[0]
            }
        } else {
            return contactList.peopleList.filter { person in
                person.name[0].lowercased().contains(searchText.lowercased()) || person.name[1].lowercased().contains(searchText.lowercased())
            }.sorted{
                $0.name[0] < $1.name[0]
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(Contacts())
    }
}
