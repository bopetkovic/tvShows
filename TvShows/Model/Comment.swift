//
//  Comment.swift
//  TvShows
//
//  Created by Bojan Petkovic on 30/09/2018.
//

import Foundation

struct Comment: Decodable {
    let id: String
    let text: String
    let userEmail: String
    let episodeId: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case userEmail
        case episodeId
    }
}
