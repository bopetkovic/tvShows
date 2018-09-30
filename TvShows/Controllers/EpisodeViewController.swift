//
//  EpisodeViewController.swift
//  TvShows
//
//  Created by Bojan Petkovic on 30/09/2018.
//

import UIKit
import Alamofire
import CodableAlamofire

class EpisodeViewController: UIViewController {
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeCount: UILabel!
    @IBOutlet weak var episodeDescription: UITextView!
    @IBOutlet weak var commentsButton: UIButton!
    
    var episodeId: String?
    var baseUrl = "https://api.infinum.academy/api/episodes/"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEpisodeDetails()
    }

    func fetchEpisodeDetails() {
        let url = "\(baseUrl)\(episodeId!)"
        Alamofire.request(url, method: .get, parameters: [:], encoding: JSONEncoding.default).validate().responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<EpisodeDetails>) in
//            print("This is response: \(response)")
//            print("This is episode details reponse: \(response.result.value)")
            
            let responseObject = response.result.value
            let imageData = ImageHelper.createImageData(imageId: (responseObject?.imageUrl)!)
            self.episodeImage.image = UIImage(data: imageData)
            
            self.episodeTitle.text = responseObject?.title
            
            self.episodeCount.text = "S\((responseObject?.season)!) Ep\((responseObject?.episodeNumber)!)"
            
            self.episodeDescription.text = responseObject?.description
        }
    }
}
