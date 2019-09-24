
//Shivang Ranjan

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadPosts()
        
    }
    
    func loadPosts() {
        
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
            print(Thread.isMainThread)
            print(snapshot.value)
            if let dict = snapshot.value as? [String: Any] {
//                let post = Post()
                let newPost = Post.transformPost(dict: dict)
                
                self.posts.append(newPost)
                print(self.posts)
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func logout_TouchUpInside(_ sender: Any) {
        print(Auth.auth().currentUser)
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Start", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion: nil)

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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].caption
        return cell
    }
    
    
}

