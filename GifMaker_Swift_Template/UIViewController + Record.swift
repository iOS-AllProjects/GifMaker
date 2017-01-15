//
//  UIViewController + Record.swift
//  GifMaker_Swift_Template
//
//  Created by Etjen Ymeraj on 10/3/16.
//  Copyright © 2016 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func launchVideoCamera(sender: AnyObject){
        callActionSheet()
        print("launch")
    }
    
    func callActionSheet(){
        let actionSheet = UIAlertController(title: "Create a Gif", message: "Upload from the following", preferredStyle: .ActionSheet)
        let libraryAction = UIAlertAction(title: "Phone Library", style: .Default){ action in
            self.fromSource(.PhotoLibrary)
        }
        let takePhotoAction = UIAlertAction(title: "Take a Video", style: .Default){ action in
            self.fromSource(.Camera)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(cancelAction)
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }

    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
      let mediaType = info[UIImagePickerControllerMediaType] as! String
            if mediaType ==  kUTTypeMovie as String {
                let videoURL = info[UIImagePickerControllerMediaURL] as! NSURL
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path!, nil, nil, nil)
            }else { print("Failed to save video") }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func fromSource(source: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let picker = UIImagePickerController()
            picker.sourceType = source
            picker.mediaTypes = [kUTTypeMovie as String]
            picker.delegate = self
            picker.allowsEditing = false
            presentViewController(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Not Available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default) { alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
                })
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}
