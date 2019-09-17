//
//  AuthService.swift
//  sozial
//
//  Created by Shivang Ranjan on 17/09/19.
//  Copyright © 2019 shivangcodes. All rights reserved.
//

import Foundation
import FirebaseAuth

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
  
}
