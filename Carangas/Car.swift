//
//  Car.swift
//  Carangas
//
//  Created by Vitoria Ortega on 26/06/24.
//  Copyright © 2024 Eric Brito. All rights reserved.
//

import Foundation

class Cars: Codable {
    var _id: String
    var brand: String
    var gasType: Int
    var name: String
    var price: Double
    
    var gas: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Álcool"
        default:
            return "Gasolina"
        }
    }
}
