

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    
}

