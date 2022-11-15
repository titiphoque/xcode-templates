//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit
import Foundation

protocol CellIdentifiable {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension CellIdentifiable {
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}
