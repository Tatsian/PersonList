//
//  CollectionViewCell.swift
//  PersonList
//
//  Created by Tatsiana on 14.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personData: UILabel!
      
    var person: PersonData? {
        didSet {
            guard let person = person else {
                return
            }
            personName.text = person.name
            personData.text = person.gender + " " + person.age
            
        }
    }
}
