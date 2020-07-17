//
//  PersonDataViewController.swift
//  PersonList
//
//  Created by Tatsiana on 14.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

final class PersonDataViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var birhtdayLabel: UILabel!
        

    var person: PersonData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let openedPerson = person else {
            return
        }
        nameLabel.text = openedPerson.name
        genderLabel.text = openedPerson.gender
        emailLabel.text = openedPerson.email
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        birhtdayLabel.text = formatter.string(from: openedPerson.dateOfBirtdh)
    }
}
