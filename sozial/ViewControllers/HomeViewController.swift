//
//  HomeViewController.swift
//  sozial
//
//  Created by Shivang Ranjan on 31/08/19.
//  Copyright © 2019 shivangcodes. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func logout_TouchUpInside(_ sender: Any) {
        print(Auth.auth().currentUser)
        do {
            try Auth.auth().signOut()

        }catch let logoutError {
            print(logoutError)
        }
        
        print(Auth.auth().currentUser)
        
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signInVC, animated: true , completion: nil)
        
        
    }
    
}
