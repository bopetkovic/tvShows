//
//  EpisodeCell.swift
//  TvShows
//
//  Created by Bojan Petkovic on 28/09/2018.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var episodeCounter: UILabel!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setArrowImage()
        episodeCounter.textColor = UIColor(red: 255.0/255.0, green: 117.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setArrowImage() {
        arrowImage.image = UIImage(named: "ic-navigation-chevron-right-medium")
    }
    
}
