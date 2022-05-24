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
    @State private var showVisits = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.881832, longitude: -87.623177), span: MKCoordinateSpan(latitudeDelta: 11, longitudeDelta: 11))
    @StateObject private var locationController = LocationController()
    
    var body: some View {
        ZStack {
            MapContainer
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
                .onAppear {
                    locationController.monitorGeofencedLocations()
                }
                .sheet(isPresented: $showVisits) {
                    GeofenceHistoryView(locationController: locationController)
                }
            HistoryButton
        }
    }
    var MapContainer: some View {
        Map(
            coordinateRegion: $region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            annotationItems: locationController.geofencedLocations
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
    }
    
    var HistoryButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button { showVisits.toggle() } label: {
                    Image(systemName: "chart.bar.doc.horizontal")
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .frame(width: 65, height: 65, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(50)
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
