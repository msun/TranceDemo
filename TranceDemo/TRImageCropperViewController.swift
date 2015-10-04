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

    @IBOutlet weak var imageView: UIImageView!
    var image : UIImage? = nil {
        didSet {
            imageView?.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image;
    }

    @IBAction func doneTapped(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.unwindToFeedViewControllerSegue:
                if let _ = segue.destinationViewController.contentViewController as? TRFeedViewController{
                    print("prepare unwindToFeedViewControllerSegue")
                }
            default:
                break
            }
        }
    }

    @IBAction func cropTapped(sender: AnyObject) {
        if let width = image?.size.width, height = image?.size.height {
            let rect = CGRectMake(width / 4, height / 4, width / 2, height / 2)
            if let croppedImage = CGImageCreateWithImageInRect(image?.CGImage, rect) {
                image = UIImage(CGImage: croppedImage)
            } else {
                print("cropped failed1")
            }
        } else {
            print("cropped failed2")
        }
        
    }
}
