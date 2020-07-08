//
//  RegionBanksList.swift
//  BankFinder
//
//  Created by Mike Camara on 23/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import SwiftUI

struct RegionBanksList: View {
    
    @ObservedObject var regionsVM = BanksViewModel()
    @State var isActive = false
    @State var showingDetail = false
    var regionName: String
    var countryName: String
    
    var body: some View {
        List {
            Section(header: Text("")) {
                if countryName == "Estonia" {
                    ForEach(regionsVM.banksInEstoniaRegion) { bank in
                        Button(action: {
                            self.showingDetail.toggle()
                        }) {
                            BankRow(bank: bank)
                        }.sheet(isPresented: self.$showingDetail) {
                            BankDetails(bank: bank)
                        }
                    }
                } else if countryName == "Latvia" {
                    ForEach(regionsVM.banksInLatviaRegion) { bank in
                        Button(action: {
                            self.showingDetail.toggle()
                        }) {
                            BankRow(bank: bank)
                        }.sheet(isPresented: self.$showingDetail) {
                            BankDetails(bank: bank)
                        }
                    }
                } else {
                    ForEach(regionsVM.banksInLithuaniaRegion) { bank in
                        Button(action: {
                            self.showingDetail.toggle()
                        }) {
                            BankRow(bank: bank)
                        }.sheet(isPresented: self.$showingDetail) {
                            BankDetails(bank: bank)
                        }
                    }
                }
            }
        }.listStyle(GroupedListStyle())
        .onAppear {
            self.regionsVM.fetchBanksFromRegion(regionName: self.regionName, countryName: self.countryName)    
        }
        .navigationBarTitle(self.regionName)
        .accessibility(identifier: "regionBankList")
    }
}

