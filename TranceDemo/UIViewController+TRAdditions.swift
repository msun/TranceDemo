//
//  UIViewController+TRAdditions.swift
//  TranceDemo
//
//  Created by Matthew Sun on 10/1/15.
//  Copyright © 2015 Matthew Sun. All rights reserved.
//

import UIKit

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            if let viscon = navcon.visibleViewController {
                return viscon
            } else {
                return self
            }
        } else {
            return self
        }
    }
}