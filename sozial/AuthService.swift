//
//  AuthService.swift
//  sozial
//
//  Created by Shivang Ranjan on 17/09/19.
//  Copyright © 2019 shivangcodes. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
class AuthService {
    static func signIn(email: String, password: String, onSuccess: @escaping () ->Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        print("sign in")
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            //@escaping applied to tell the program that it is to be called once the program has successfully executed.
            onSuccess()
        }
    }
    
    static func signUp(username: String,email: String, password: String,imageData: Data, onSuccess: @escaping () ->Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        print("sign in")

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            let uid = authResult?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("profile_image").child(uid!)
            
                storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    let profileImageUrl = metadata?.downloadURL()?.absoluteString
                    
                    self.setUserInfomation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!, onSuccess: onSuccess)
                })
            
            
        }
    }
    
    static func setUserInfomation(profileImageUrl: String, username: String,email: String, uid: String,  onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "email": email, "profileImageUrl": profileImageUrl])
        onSuccess()
    }



}
