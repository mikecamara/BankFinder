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
    @State private var showShareSheet = false
    @State public var sharedItems : [Any] = []
    var bank: BankLocation
    @Environment(\.presentationMode) var presentation
    
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
    
    func openMap() {
        let latitute:CLLocationDegrees =  bank.lat ?? 0.0
        let longitute:CLLocationDegrees =  bank.lon ?? 0.0

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = bank.n
        mapItem.openInMaps(launchOptions: options)
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack{
                    Spacer()
                    Button(action: { self.presentation.wrappedValue.dismiss() }) {  Image(systemName: "xmark.circle.fill") }
                    .padding()
                }
            }
            MapView(coordinate: returnLocation2D(latitude: bank.lat ?? 0.0, longitude: bank.lon ?? 0.0), name: bank.n ?? "")
                .edgesIgnoringSafeArea(.top)
                .frame(height: 220)
            
            VStack {
                HStack{
                     Button(
                         action: {
                            var bankAvailabilityString: String = ""
                            if let bankAvailability = self.bank.av {
                                bankAvailabilityString = bankAvailability
                            }
                            var bankNameString: String = ""
                            if let bankName = self.bank.n {
                                bankNameString = bankName
                            }
                            var bankAddressString: String = ""
                            if let bankAddress = self.bank.a {
                                bankAddressString = bankAddress
                            }
                            
                            var bankRegionString: String = ""
                            if let bankRegion = self.bank.r {
                                bankRegionString = bankRegion
                            }
                            var bankTypeString: String = ""
                            if let bankType = self.bank.t {
                               bankTypeString =  self.returnTypeValue(type: bankType)
                            }
                            var bankInfoString: String = ""
                            if let bankInfo = self.bank.i {
                                bankInfoString = bankInfo
                            }
                            var text = "Type: "  + bankTypeString
                                + "\n Name: " +  bankNameString + "\n"
                                + "Address: " + bankAddressString + "\n"
                                + "Region: " + bankRegionString + "\n"
                                + "Availability: " + bankAvailabilityString + "\n"
                                + "Info: " + bankInfoString
                           self.sharedItems = [text]
                           self.showShareSheet = true
                         }
                     ) {
                        Image(systemName: "square.and.arrow.up").imageScale(.large)
                     }.sheet(isPresented: $showShareSheet) {
                         ShareSheet(activityItems: self.sharedItems)
                     }

                    Spacer()
                    Button(action: { self.openMap()  }) { Text("Directions") }
                }
                .padding()
            }
            List {
                Section (header: Text(""), footer: Text(""), content: {
                    HStack(alignment: .center){
                        Spacer()
                        Text("TYPE").foregroundColor(.secondary).font(.subheadline)
                        Text(returnTypeValue(type: bank.t ?? 0)).foregroundColor(.primary)
                        Spacer()
                    }
                    HStack(alignment: .center){
                        Spacer()
                        Text("NAME").foregroundColor(.secondary).font(.subheadline)
                        Text("\(bank.n ?? "")").foregroundColor(.primary)
                        Spacer()
                    }
                    HStack(alignment: .center){
                        Spacer()
                        Text("ADDRESS").foregroundColor(.secondary).font(.subheadline)
                        Text("\(bank.a ?? "")").foregroundColor(.primary)
                        Spacer()
                    }
                    HStack(alignment: .center){
                        Spacer()
                        Text("REGION").foregroundColor(.secondary).font(.subheadline)
                        Text("\(bank.r ?? "")").foregroundColor(.primary)
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
            .navigationBarTitle(bank.n ?? "")
        }
    }
}

func returnLocation2D(latitude: Double, longitude: Double)->CLLocationCoordinate2D {
    var c2D : CLLocationCoordinate2D
    c2D = CLLocationCoordinate2DMake(latitude, longitude)
    return c2D
}

struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
