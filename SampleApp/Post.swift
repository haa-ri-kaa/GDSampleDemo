//
//  Post.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 12/02/25.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
    let tags: [String]?
}

