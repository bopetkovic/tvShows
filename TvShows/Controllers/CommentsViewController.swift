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

    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        navigationItem.title = "Comments"
        
        fetchComments()
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
