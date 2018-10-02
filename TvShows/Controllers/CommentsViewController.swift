//
//  CommentsViewController.swift
//  TvShows
//
//  Created by Bojan Petkovic on 30/09/2018.
//

import UIKit
import Alamofire
import CodableAlamofire

class CommentsViewController: UIViewController {
    
    let baseUrl = "https://api.infinum.academy/api/episodes/"
    var episodeId: String?
    var commentsArray: [Comment] = [Comment]()

    @IBOutlet weak var enterCommentWrapper: UIView!
    @IBOutlet weak var commentFieldWrapper: UIView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postCommentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        navigationItem.title = "Comments"
        
        setupUI()
        
        fetchComments()
    }
    
    func setupUI() {
        let grayColor: UIColor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        let borderTop = UIView()
        borderTop.backgroundColor = grayColor
        borderTop.frame = CGRect(x: 0, y: 0, width: enterCommentWrapper.frame.size.width, height: 1)
        enterCommentWrapper.addSubview(borderTop)
        
        profileImage.layer.cornerRadius = 20
        profileImage.backgroundColor = grayColor
        
        commentFieldWrapper.layer.cornerRadius = 22
        commentFieldWrapper.layer.masksToBounds = true
        commentFieldWrapper.layer.shouldRasterize = true
        commentFieldWrapper.layer.borderWidth = 1.0
        commentFieldWrapper.layer.borderColor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0).cgColor
    }
    
    func fetchComments() {
        let url = "\(baseUrl)\(episodeId!)/comments"

        Alamofire.request(
                url,
                method: .get,
                parameters: [:],
                encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(
                keyPath: "data",
                decoder: JSONDecoder()
            ) { (response: DataResponse<[Comment]>) in
                
            let comments = response.result.value
            
            self.commentsArray = []
            for comment in comments! {
                self.commentsArray.append(comment)
            }
                
            self.commentsTableView.reloadData()
        }
    }
    
    @IBAction func sendComment(_ sender: UIButton) {
        let comment = commentTextField.text!
        print("Comment is: \(comment)")
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentsTableViewCell
        
        if indexPath.row % 3 == 0 {
            cell.profileImage.image = UIImage(named: "img-placeholder-user3")
        } else if indexPath.row % 2 == 0 {
            cell.profileImage.image = UIImage(named: "img-placeholder-user2")
        } else {
            cell.profileImage.image = UIImage(named: "img-placeholder-user1")
        }
        
        cell.username.text = commentsArray[indexPath.row].userEmail
        cell.comment.text = commentsArray[indexPath.row].text
        
        return cell
    }
    
    
}
