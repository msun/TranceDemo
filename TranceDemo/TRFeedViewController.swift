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
    private struct Constants {
        static let imageCropperSegue = "imageCropperSegue"
    }

    private var newImage : UIImage? = nil
    private var shouldShowImageCropper = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldShowImageCropper {
            shouldShowImageCropper = false;
            performSegueWithIdentifier(Constants.imageCropperSegue, sender: self)
        }
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
                newImage = UIImage(CGImage: halfTimeImage)
                shouldShowImageCropper = true;
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindToFeedViewController(segue: UIStoryboardSegue) {
        NSLog("Unwind to FeedViewController")
        if let imageCropperVC = segue.sourceViewController as? TRImageCropperViewController {
            print("Coming from imageCropperVC")
            newImage = imageCropperVC.image
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.imageCropperSegue:
                if let vc = segue.destinationViewController.contentViewController as? TRImageCropperViewController {
                    vc.image = newImage
                }
            default:
                break
            }
        }
    }
}
