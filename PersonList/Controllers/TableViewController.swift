//
//  TableViewController.swift
//  PersonList
//
//  Created by Tatsiana on 12.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

final class TableViewController: UIViewController {
    var personProvider: PersonsProvider?
    
    @IBOutlet weak var tableView: UITableView!
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personProvider?.persons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        guard let person = personProvider?.persons[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.gender + " " + person.age
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let person = personProvider?.persons[indexPath.row] else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "personDataVC") as? PersonDataViewController else {
            return
        }
        controller.person = person
        self.navigationController?.pushViewController(controller, animated: true)
    }  
}
