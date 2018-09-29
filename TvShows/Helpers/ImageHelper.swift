//
//  Image.swift
//  TvShows
//
//  Created by Bojan Petkovic on 27/09/2018.
//

import Foundation

class ImageHelper {
    static let baseUrl = "https://api.infinum.academy"
    
    class func createImageData(imageId: String) -> Data {
        let imageUrl = URL(string: "\(baseUrl)\(imageId)")
        let data = try? Data(contentsOf: imageUrl!)
        return data!
    }
}
