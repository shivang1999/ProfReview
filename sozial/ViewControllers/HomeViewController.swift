

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
        
//        var post = Post(captionText: "text", photoUrlString: "url1")
//        print(post.caption)
//        print(post.photoUrl)
        
        
        
    }
    
    func loadPosts() {
        
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
            print(Thread.isMainThread)
            print(snapshot.value)
            if let dict = snapshot.value as? [String: Any] {
                var captionText = ""
                if let caption = dict["caption"] as? String {
                    captionText = caption
                }
                let photoUrlString = dict["photoUrl"] as! String
                let post = Post(captionText: captionText, photoUrlString: photoUrlString)
                self.posts.append(post)
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

