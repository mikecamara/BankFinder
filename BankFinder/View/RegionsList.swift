//
//  RegionsList.swift
//  BankFinder
//
//  Created by Mike Camara on 21/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import SwiftUI

struct RegionsList: View {
    
    @ObservedObject var regionsVM = BanksViewModel()
    @State private var showingChildView = false
    
    var body: some View {
        NavigationView{
            List {
                Section(header: CountryHeader(countryName: "Estonia")) {
                    ForEach(regionsVM.arrayOfEstoniaRegions) { region in
                        NavigationLink(destination: RegionBanksList(regionName: "\(region.regionName ?? "")", countryName: "Estonia")) {
                            RegionRow(region: region)
                        }
                    }
                }
                Section(header: CountryHeader(countryName: "Latvia")) {
                    ForEach(regionsVM.arrayOfLatviaRegions) { region in
                        NavigationLink(destination: RegionBanksList(regionName: "\(region.regionName ?? "")", countryName: "Latvia")) {
                            RegionRow(region: region)
                        }
                    }
                }
                Section(header: CountryHeader(countryName: "Lithuania")) {
                    ForEach(regionsVM.arrayOfLithuaniaRegions) { region in
                        NavigationLink(destination: RegionBanksList(regionName: "\(region.regionName ?? "")", countryName: "Lithuania")) {
                            RegionRow(region: region)
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
            .accessibility(identifier: "regionsList")
            .navigationBarTitle("Regions")
            .navigationBarItems(trailing:Button(action: {
                    self.regionsVM.refreshAllBanks()
            }, label: {
                Text("Fetch Banks")
                }).accessibility(identifier: "refreshRegionsButton"))
        }
        .onAppear {
            self.regionsVM.fetchAllBanks()
        }
    }
}

