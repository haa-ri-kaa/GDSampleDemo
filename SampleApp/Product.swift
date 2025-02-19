//
//  Product.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 12/02/25.
//

import Foundation

struct Product: Codable, Identifiable, Sendable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let images: [String]
}
