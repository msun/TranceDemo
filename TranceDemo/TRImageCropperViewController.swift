//
//  TRImageCropperViewController.swift
//  TranceDemo
//
//  Created by Matthew Sun on 10/1/15.
//  Copyright © 2015 Matthew Sun. All rights reserved.
//

import UIKit

class TRImageCropperViewController: UIViewController {
    private struct Constants {
        static let unwindToFeedViewControllerSegue = "unwindToFeedViewControllerSegue"
    }

    @IBOutlet weak var scrollView: UIScrollView!
    var image : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = UIColor.orangeColor()
    }

    @IBAction func doneTapped(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.unwindToFeedViewControllerSegue:
                if let vc = segue.destinationViewController as? TRFeedViewController{
                    print("prepare unwindToFeedViewControllerSegue")
                }
            default:
                break
            }
        }
    }
}
