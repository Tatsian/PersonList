//
//  PersonsLoader.swift
//  PersonList
//
//  Created by Tatsiana on 13.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//


import Foundation

final class PersonsLoader {
    private static let urlString = "https://my.api.mockaroo.com/persons.json?key=f43efc60"

    static func download(completion: @escaping ([PersonData]) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                let persons = parse(data: data)
            else {
                print(error as Any)
                completion ([])
                return
            }
            print("\(persons.count) persons loaded")
            completion(persons)
        }
        dataTask.resume()
    }
    
    static func parse(data: Data) -> [PersonData]? {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try? decoder.decode([PersonData].self, from: data)
    }
}
