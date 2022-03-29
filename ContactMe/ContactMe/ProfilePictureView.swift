//
//  ProfilePictureView.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/29/22.
//

import SwiftUI

struct ProfilePictureView: View {
    @Binding var img: Image?
    
    var isContactView = false
    @Binding var person: Person
    
    var body: some View {
        if let img = img {
            img
                .resizable()
                .clipShape(Circle())
                .frame(width:150, height: 150)
                .overlay{
                    Circle()
                        .stroke()
                }
        } else if isContactView {
            
            if let usrImg = loadImage(for: person.id) {
                usrImg
                    .resizable()
                    .clipShape(Circle())
                    .frame(width:150, height: 150)
                    .overlay{
                        Circle()
                            .stroke()
                    }
            } else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .frame(width:150, height: 150)
                    .clipShape(Circle())
                    .overlay{
                        Circle()
                            .stroke()
                    }
            }
            
        } else {
            Image(systemName: "person.badge.plus")
                .resizable()
                .padding()
                .frame(width:150, height: 150)
                .clipShape(Circle())
                .overlay{
                    Circle()
                        .stroke()
                }
        }
    }
}

struct ProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePictureView(img: .constant(nil), person: .constant(janeDoeTemp))
    }
}
