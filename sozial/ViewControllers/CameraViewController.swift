//
//  CameraViewController.swift
//  sozial
//
//  Created by Shivang Ranjan on 31/08/19.
//  Copyright © 2019 shivangcodes. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    var selectedImage: UIImage?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareButton_touchUpInside(_ sender: Any) {
    }
    
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        print("did Finish Picking media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            photo.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
}
