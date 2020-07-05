//
//  CountryHeader.swift
//  BankFinder
//
//  Created by Mike Camara on 22/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import SwiftUI

struct CountryHeader: View {
    var countryName: String
    var body: some View {
        HStack {
            if (countryName == "Estonia"){
                Text("🇪🇪")
                Text(countryName)
            } else if (countryName == "Estonia") {
                Text("🇱🇻")
                Text(countryName)
            } else {
                Text("🇱🇹")
                Text(countryName)
            }
        }
    }
}


