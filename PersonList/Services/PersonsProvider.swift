//
//  PersonsProvider.swift
//  PersonList
//
//  Created by Tatsiana on 13.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import Foundation

final class PersonsProvider {
    var selectedGender: String?
    var selectedSort: SortType = .ageAscending
        
    private var allPersons = [PersonData]()
    var genders = Set<String>()
    
    var persons: [PersonData] {
        return personsWith(sort: selectedSort, gender: selectedGender)
    }
    
    func reload(completion: @escaping () -> ()) {
        PersonsLoader.download { [weak self] (persons) in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.allPersons = persons
                self.genders = Set(persons.map({ $0.gender }))
                completion()
            }
        }
    } 
    
    private func personsWith(sort: SortType, gender: String?) -> [PersonData] {
        var result = allPersons
        if let selectedGender = gender {
            result = result.filter({ $0.gender == selectedGender })
        }
        result = result.sorted(by: { (leftElement, rightElement) in
            switch sort {
            case .ageAscending:
                return leftElement.dateOfBirtdh < rightElement.dateOfBirtdh
            case .ageDescending:
                return leftElement.dateOfBirtdh > rightElement.dateOfBirtdh
            }
        })
        
        return result
    }
}
