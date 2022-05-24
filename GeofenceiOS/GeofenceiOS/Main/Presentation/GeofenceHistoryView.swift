//
//  GeofenceHistoryView.swift
//  GeofenceiOS
//
//  Created by Mwai Banda on 5/24/22.
//

import SwiftUI

struct GeofenceHistoryView: View {
    @ObservedObject var locationController: LocationController
    var body: some View {
        VStack {
            HStack {
                Text("Geofence History")
                    .font(.title)
                    .bold()
                    .padding(.top)
                Spacer()
            }
            .padding(.leading)
            .padding(.leading)
            ForEach(locationController.geofencedLocations, id: \.id) { location in
                PlainExpandableCard {
                    Text(location.name)
                } coverIcon: { isExpanded in
                    Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                        .foregroundColor(.gray)
                } innerContent: {
                    VStack {
                    ForEach(locationController.history.filter({ $0.name == location.name }), id: \.id) { visit in
                        HStack {
                        Text("• ") +
                        Text("Visited ").bold() +
                        Text(" \(visit.name) at ") +
                        Text ("\(visit.visitationStart)").bold() +
                        Text(visit.visitationEnd.isEmpty ? "" : " and ") +
                        Text(visit.visitationEnd.isEmpty ? "" : "left ").bold() +
                        Text(visit.visitationEnd.isEmpty ? "" : "\(visit.visitationEnd)").bold()
                        Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.top)

                        Divider()
                            .padding(.top)

                    }
                        
                        Spacer()

                    }
                    .multilineTextAlignment(.leading)
                    .padding(.vertical)
                    
                }
            }
            Spacer()
        }

    }
}

struct GeofenceHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GeofenceHistoryView(locationController: LocationController())
    }
}
