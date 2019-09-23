//
//  CameraViewController.swift
//  ProfReview
//
//  Created by Shivang Ranjan on 31/08/19.
//  Copyright © 2019 shivangcodes. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class CameraViewController: UIViewController {

    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var removeButton: UIBarButtonItem!
    var selectedImage: UIImage?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
    }
    
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    func handlePost() {
        if selectedImage != nil {
            
            self.shareButton.isEnabled = true
            self.removeButton.isEnabled = true
            self.shareButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            self.shareButton.isEnabled = false
            self.removeButton.isEnabled = false

            self.shareButton.backgroundColor = .lightGray
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
//        view.endEditing(false)
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareButton_touchUpInside(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("waiting..", interaction: false)
        if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            let photoIdString = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("posts").child(photoIdString)
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                let photoUrl = metadata?.downloadURL()?.absoluteString
                self.sendDataToDatabase(photoUrl: photoUrl!)
            })
        }
        else {
            ProgressHUD.showError("Profile Image can't be empty")
        }
    }
    
    @IBAction func remove_TouchUpInside(_ sender: Any) {
        clean()
    }
    
    func sendDataToDatabase(photoUrl: String) {
        let ref = Database.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId)
        newPostReference.setValue(["photoUrl": photoUrl, "caption": captionTextView.text!]) { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
            self.clean()
            self.tabBarController?.selectedIndex = 0
            
        }
    }
    
    func clean() {
        self.captionTextView.text = ""
        self.photo.image = UIImage(named: "placeholder-photo")
        self.selectedImage = nil
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
