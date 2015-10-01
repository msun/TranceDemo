//
//  TRNavigationController.swift
//  TranceDemo
//
//  Created by Matthew Sun on 9/30/15.
//  Copyright © 2015 Matthew Sun. All rights reserved.
//

import UIKit

class TRNavigationController: UINavigationController {
    
    private struct Constants {
        static let navBarImageName = "title_bar_no_logo"
    }
        
    override func viewDidLoad() {
        let barImage = UIImage(named: Constants.navBarImageName)!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch)
        UINavigationBar.appearance().setBackgroundImage(barImage, forBarMetrics: .Default)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
