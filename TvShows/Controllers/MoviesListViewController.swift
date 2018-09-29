//
//  MoviesListViewController.swift
//  TvShows
//
//  Created by Bojan Petkovic on 26/09/2018.
//

import UIKit
import Alamofire
import CodableAlamofire

class MoviesListViewController: UIViewController {
    
    let baseUrlString: String = "https://api.infinum.academy"
    var moviesList: [Movie] = [Movie]()
    var showId: String?

    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // set table delegate and data source
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        // register table custom cell
        moviesTableView.register(UINib(nibName: "MoviesListCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        
        collectMovies()
        setupUI()
        print("----Movies list count is: \(moviesList.count)")
    }

    @objc func logOut() {
        performSegue(withIdentifier: "logOut", sender: self)
        UserDefaults.standard.set(false, forKey: "rememberMe")
        UserDefaults.standard.set(false, forKey: "authenticatedUser")
    }
    
    func setupUI() {
        // removes bottom border from cell
        moviesTableView.separatorStyle = .none
        
        // hide back button
        navigationItem.hidesBackButton = true
        
        // set logOut button
        let buttonImage = UIImage(named: "ic-logout")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(logOut))
        
        // set app title
        let appTitle = UILabel()
        appTitle.text = "Shows"
        appTitle.font = UIFont(name: appTitle.font.fontName, size: 22.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: appTitle)

        NavigationControllerHelper.setTransparentHeaders(navigationController: (navigationController)!)
    }
    
    func collectMovies() {
        let url = "\(baseUrlString)/api/shows"
        
        Alamofire.request(
                url,
                method: .get,
                parameters: [:],
                encoding: JSONEncoding.default
            )
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<[Movie]>) in
                let movies = response.result.value
                
                self.moviesList = [Movie]()
                
                for movie in movies! {
                    self.moviesList.append(movie)
                }
                
                if self.moviesList.count > 0 {
                    self.moviesTableView.reloadData()
                }
                
//                print("Movies list: \(self.moviesList)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let vc = segue.destination as! ShowViewController
            vc.showId = showId
        }
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesListCell
        cell.movieTitle.text = moviesList[indexPath.row].title
        
        let data = ImageHelper.createImageData(imageId: moviesList[indexPath.row].imageUrl)
        cell.movieImage.image = UIImage(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showId = moviesList[indexPath.row].id
        performSegue(withIdentifier: "showDetails", sender: self)
    }
}
