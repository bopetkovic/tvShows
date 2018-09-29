//
//  ShowDetails.swift
//  TvShows
//
//  Created by Bojan Petkovic on 27/09/2018.
//

import Foundation

struct ShowDetails: Decodable {
    let id: String
    let type: String
    let title: String
    let imageUrl: String
    let likesCount: Int
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case title
        case imageUrl
        case likesCount
        case description
    }
}
