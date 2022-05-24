//
//  ContentView.swift
//  GeofenceiOS
//
//  Created by Mwai Banda on 5/23/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    @State private var showTitles = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.881832, longitude: -87.623177), span: MKCoordinateSpan(latitudeDelta: 11, longitudeDelta: 11))
    let annotations = [
        Location(name: "Chicago Midway International Airport", latitude: 41.78499686, longitude: -87.751496994),
        Location(name: "O’Hare International Airport", latitude: 41.978611, longitude: -87.904724),
        Location(name: "Shedd Aquarium", latitude: 41.8670292454, longitude: -87.6134396189),
        Location(name: "Nando's Peri Peri Chicken", latitude: 41.90855, longitude: -87.64636)
    ]
    var body: some View {
        Map(
            coordinateRegion: $region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            annotationItems: annotations
        ) { coo in
            MapAnnotation(coordinate: coo.coordinate) {
                VStack {
                    ZStack {
                        Circle()
                            .foregroundColor(.red.opacity(0.4))
                            .frame(width: 100, height: 100)
                            .zIndex(0)
                        
                        Image(systemName: "mappin").imageScale(.large)
                            .zIndex(2)
                        
                    }.onTapGesture {
                        showTitles.toggle()
                    }
                    if showTitles {
                        Text(coo.name)
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
