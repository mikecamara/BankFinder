//
//  BankDetails.swift
//  BankFinder
//
//  Created by Mike Camara on 24/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import SwiftUI
import MapKit

struct BankDetails: View {
    @State var isActive = false
    @State var showingDetail = false
    var bank: BankLocation
    
    func returnTypeValue(type: Int) -> String {
        // 0 — Branch
        // 1 — ATM (Automated Teller Machine)
        // 2 — BNA (Bunch Note Acceptor)
        var typeString: String
        switch type {
            case 0:
                typeString = "Branch"
            case 1:
                typeString = "ATM (Automated Teller Machine)"
            case 2:
                typeString = "BNA (Bunch Note Acceptor)"
            default:
                typeString = ""
        }
        return typeString
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("hi")
            }
            MapView(coordinate: returnLocation2D(latitude: bank.lat ?? 0.0, longitude: bank.lon ?? 0.0), name: bank.n ?? "")
                .edgesIgnoringSafeArea(.top)
                .frame(height: 200)
            List {
                Section (header: Text(""), footer: Text(""), content: {
                    HStack(alignment: .center){
                        Spacer()
                        Text("TYPE").foregroundColor(.secondary).font(.subheadline)
                        Text(returnTypeValue(type: bank.t!)).foregroundColor(.primary)
                        Spacer()
                    }
                    HStack(alignment: .center){
                        Spacer()
                        Text("NAME").foregroundColor(.secondary).font(.subheadline)
                        Text("\(bank.n!)").foregroundColor(.primary)
                        Spacer()
                    }
                    HStack(alignment: .center){
                        Spacer()
                        Text("ADDRESS").foregroundColor(.secondary).font(.subheadline)
                        Text("\(bank.a!)").foregroundColor(.primary)
                        Spacer()
                    }
                    HStack(alignment: .center){
                        Spacer()
                        Text("REGION").foregroundColor(.secondary).font(.subheadline)
                        Text("\(bank.r!)").foregroundColor(.primary)
                        Spacer()
                    }
                })
                Section {
                    if bank.av != nil {
                       HStack(alignment: .center){
                            Spacer()
                            Text("AVAILABILITY").foregroundColor(.secondary).font(.subheadline)
                            Text("\(bank.av ?? "")").foregroundColor(.primary)
                            Spacer()
                       }
                    }
                    if bank.i != nil {
                        HStack(alignment: .center){
                            Spacer()
                            Text("INFO").foregroundColor(.secondary).font(.subheadline)
                            Text("\(bank.i  ?? "")").foregroundColor(.primary)
                            Spacer()
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(bank.n!)
        }
    }
}

func returnLocation2D(latitude: Double, longitude: Double)->CLLocationCoordinate2D {
    var c2D : CLLocationCoordinate2D
    c2D = CLLocationCoordinate2DMake(latitude, longitude)
    return c2D
}

