//
//  Visit.swift
//  GeofenceiOS
//
//  Created by Mwai Banda on 5/24/22.
//

import Foundation

struct Visit: Identifiable {
    let id = UUID()
    let name: String
    let visitationStart: Date
    let visitationEnd: Date
}
