//
//  MapView.swift
//  BankFinder
//
//  Created by Mike Camara on 5/7/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var name: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.mapType = MKMapType.standard // (satellite)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = name
        view.addAnnotation(annotation)
    }
}

