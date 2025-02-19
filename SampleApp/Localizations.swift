//
//  Localisations.swift
//  SampleApp
//
//  Created by Harika Rudraraju on 17/02/25.
//

import Foundation


struct Localizations {
    /// Search Products Copy
    static let searchProducts = "SearchProducts".localized
    
    /// Products copy
    static let products = "Products".localized
    
    /// Price copy
    static let price = "Price".localized

}
extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }
}
