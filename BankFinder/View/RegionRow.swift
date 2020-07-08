//
//  RegionRow.swift
//  BankFinder
//
//  Created by Mike Camara on 22/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import SwiftUI

struct RegionRow: View {
    var region: Region
    var body: some View {
        HStack {
            Text("\(region.regionName ?? "")").foregroundColor(.secondary)
            Spacer()
        }
    }
}

