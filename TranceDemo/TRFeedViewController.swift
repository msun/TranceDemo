//
//  TRFeedViewController.swift
//  TranceDemo
//
//  Created by Matthew Sun on 9/30/15.
//  Copyright © 2015 Matthew Sun. All rights reserved.
//

import UIKit

import MobileCoreServices
import AVFoundation

class TRFeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cameraButtonTapped(sender: AnyObject) {
        NSLog("cameraButtonTapped")
        
        let picker = UIImagePickerController()
        picker.delegate = self
        //picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = .Camera
            if let availableTypes = UIImagePickerController.availableMediaTypesForSourceType(.Camera) {
                if (availableTypes as NSArray).containsObject(kUTTypeMovie) {
                    picker.mediaTypes = [kUTTypeMovie as String]
                    self.presentViewController(picker, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // if info[UIImagePickerControllerMediaType] == kUTTypeMovie
        
        if let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL {
            print("Video URL: ", videoURL.absoluteString)
            let sourceAsset = AVURLAsset(URL: videoURL)
            let duration = sourceAsset.duration
            let halfTime = CMTimeMultiplyByFloat64(duration, 0.5)
            let generator = AVAssetImageGenerator(asset: sourceAsset)
            var actualTime : CMTime = CMTimeMake(0, 0)
            var halfTimeImage : CGImage? = nil
            do {
                try halfTimeImage = generator.copyCGImageAtTime(halfTime, actualTime: &actualTime)
            } catch is CGImage {
                print("halfTimeImage error")
            } catch {
                print("halfTimeImage error2")
            }
            if let halfTimeImage = halfTimeImage as CGImage! {
                imageView.image = UIImage(CGImage: halfTimeImage)
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
