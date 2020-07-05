//
//  Region.swift
//  BankFinder
//
//  Created by Mike Camara on 22/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import Foundation

struct Region: Identifiable, Decodable {
    let id = UUID()
    let regionName: String?
}
