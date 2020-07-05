//
//  BankLocation.swift
//  BankFinder
//
//  Created by Mike Camara on 21/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import Foundation

struct BankLocation: Identifiable, Codable {
    let id = UUID()
    // Type
    let t: Int?
    // Name
    let n: String?
    // Address
    let a: String?
    // Region
    let r: String?
    // Availability
    let av: String?
    // Latitude
    let lat: Double?
    // Longitude
    let lon: Double?
    // Info
    let i: String?
}
