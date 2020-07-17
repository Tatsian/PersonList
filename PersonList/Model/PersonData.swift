//
//  PersonData.swift
//  PersonList
//
//  Created by Tatsiana on 12.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//
import Foundation
struct Persons: Codable {
    let personData: [PersonData]
}
struct PersonData: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let gender: String
    let dateOfBirtdh: Date
    
    var name: String { return firstName + " " + lastName }
    var age: String { return PersonData.self.ageCalculate(birthDate: dateOfBirtdh)}
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case gender
        case dateOfBirtdh
    }
}

extension PersonData {
    static func ageCalculate(birthDate: Date) -> String {
        let today = Date()
        let components = Calendar.current.dateComponents([.month, .day, .year], from: birthDate, to: today)
        
        guard let ageYears = components.year else {
            return ""
        }
        
        return String(ageYears)
    }
}
