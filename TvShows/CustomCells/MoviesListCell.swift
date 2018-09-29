//
//  MoviesListCell.swift
//  TvShows
//
//  Created by Bojan Petkovic on 26/09/2018.
//

import UIKit

class MoviesListCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setBorderAroundImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setBorderAroundImage() {
        movieImage.layer.cornerRadius = 5.0
        movieImage.layer.masksToBounds = true
    }
}
