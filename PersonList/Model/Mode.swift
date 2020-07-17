//
//  Mode.swift
//  PersonList
//
//  Created by Tatsiana on 13.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

enum Mode {
    case table
    case collection
    
    var image: UIImage? {
        switch self {
        case .table:
            return UIImage(systemName: "line.horizontal.3")
        case .collection:
            return UIImage(systemName: "square.grid.2x2")
        }
    }
}
