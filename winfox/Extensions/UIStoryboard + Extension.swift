//
//  UIStoryboard.swift
//  QuranAcademy
//
//  Created by Ayub on 19.04.2018.
//  Copyright © 2018 Ayub. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func get<T>(_ type: T.Type) -> T {
        let id = String(describing: type)
        let storyboard = UIStoryboard(name: id, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            return storyboard.instantiateViewController(withIdentifier: id) as! T
        }
    }
    
}

extension UIViewController {
    
    static func loadFromStoryboard() -> Self {
        return UIStoryboard.get(self)
    }
    
}
