//
//  EMailValid.swift
//  ContactMe
//
//  Created by Luthfor Khan on 3/28/22.
//

import Foundation


func checkIfValidEmail(input: String) -> Bool {
    let pattern = #"(?!.*[._@-]{2,})^[^._-][a-zA-Z0-9._-]+[^._-]@[^._-][a-zA-Z0-9._-]+[^._@-]+\.[a-zA-z]{2,}+$"#
    let range = NSRange(location: 0, length: input.count)
    let regex = try! NSRegularExpression(pattern: pattern)

    if input.contains("@") && input.contains(".") {
        return regex.firstMatch(in: input, options: [], range: range) != nil
    }
    
    return false
}
