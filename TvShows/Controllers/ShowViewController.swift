//
//  ShowViewController.swift
//  TvShows
//
//  Created by Bojan Petkovic on 27/09/2018.
//

import UIKit
import Alamofire
import CodableAlamofire

class ShowViewController: UIViewController {
    
    let showBaseUrl = "https://api.infinum.academy/api/shows/"
    var chosenShow: ShowDetails?
    var showId: String?
    var episodeId: String?
    var episodesArray: [Episode] = [Episode]()

    @IBOutlet weak var episodesTableView: UITableView!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var episodesNumber: UILabel!
    @IBOutlet weak var addEpisodeButton: UIButton!
    @IBOutlet weak var tableHeader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // register nib and set delegate and dataSource
        episodesTableView.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "episodeCell")
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        
        // fetch data and setup layout
        fetchShowDetails()
        fetchEpisodes()
        setupUI()
    }
    
    func setupUI() {
        // removes bottom border from cell
        episodesTableView.separatorStyle = .none
        
        NavigationControllerHelper.setTransparentHeaders(navigationController: (navigationController)!)
        
        showDescription.sizeToFit()
        // addEpisode button
        let episodeButtonImage = UIImage(named: "ic-fab-button")
        addEpisodeButton.setBackgroundImage(episodeButtonImage, for: .normal)
        addEpisodeButton.setTitle("", for: .normal)
    }
    
    func populateInterface() {
        // this is base url for image https://api.infinum.academy
        let data = ImageHelper.createImageData(imageId: (chosenShow?.imageUrl)!)
        showImage.image = UIImage(data: data)
        
        showTitle.text = chosenShow?.title
        showDescription.text = chosenShow?.description
    }
    
    func fetchShowDetails() {
        let url = "\(showBaseUrl)\(showId!)"
        Alamofire.request(
                url,
                method: .get,
                parameters: [:],
                encoding: JSONEncoding.default
            ).validate()
            .responseDecodableObject(
                keyPath: "data",
                decoder: JSONDecoder()
            ) { (response: DataResponse<ShowDetails> ) in
            self.chosenShow = response.result.value
            
            self.populateInterface()
        }
    }
    
    func fetchEpisodes() {
        let episodesUrl = "\(showBaseUrl)\(showId!)/episodes"
        Alamofire.request(
                episodesUrl,
                method: .get,
                parameters: [:],
                encoding: JSONEncoding.default
            ).validate()
            .responseDecodableObject(
                keyPath: "data",
                decoder: JSONDecoder()
            ) { (response: DataResponse<[Episode]>) in

            let episodes = response.result.value
            
            self.episodesArray = [Episode]()
            
            for episode in episodes! {
                self.episodesArray.append(episode)
            }
            
            self.episodesNumber.text = String(self.episodesArray.count)
            self.episodesTableView.reloadData()
        }
    }
    
    @IBAction func moveToAddEpisode(_ sender: UIButton) {
        performSegue(withIdentifier: "addEpisode", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backButton = UIBarButtonItem()
        
        if segue.identifier == "addEpisode" {
            let vc = segue.destination as! AddEpisodeViewController
            vc.showId = showId!
            
            backButton.title = "Cancel"
            backButton.tintColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 147.0/255.0, alpha: 1.0)
            navigationItem.backBarButtonItem = backButton
        }
        
        if segue.identifier == "showEpisode" {
            let vc = segue.destination as! EpisodeViewController
            vc.episodeId = episodeId
            
            backButton.title = ""
            navigationItem.backBarButtonItem = backButton
        }
    }
}

// MARK: - table setup
extension ShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodesTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeCell
        
        let episodeCountText = "S\(episodesArray[indexPath.row].season) Ep\(episodesArray[indexPath.row].episodeNumber)"
        cell.episodeCounter.text = episodeCountText
        
        cell.episodeTitle.text = episodesArray[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        episodeId = episodesArray[indexPath.row].id
        print("This is episode id \(episodeId!)")
        performSegue(withIdentifier: "showEpisode", sender: self)
    }
}
