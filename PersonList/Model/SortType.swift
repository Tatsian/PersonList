//
//  PersonListViewController.swift
//  PersonList
//
//  Created by Tatsiana on 13.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

enum SortType {
    case ageAscending, ageDescending
    
    var image: UIImage? {
        switch self {
        case .ageAscending:
            return UIImage(systemName: "arrow.up")
        case .ageDescending:
            return UIImage(systemName: "arrow.down")
        }
    }
}
