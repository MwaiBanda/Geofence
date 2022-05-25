//
//  Location.swift
//  GeofenceiOS
//
//  Created by Mwai Banda on 5/23/22.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Location: Equatable {
    
}
