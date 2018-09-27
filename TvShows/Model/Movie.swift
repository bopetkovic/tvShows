//
//  Movie.swift
//  TvShows
//
//  Created by Bojan Petkovic on 26/09/2018.
//

import Foundation
import UIKit

struct Movie: Decodable {
    let id: String
    let title: String
    let imageUrl: String
    let likesCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case imageUrl
        case likesCount
    }
}
