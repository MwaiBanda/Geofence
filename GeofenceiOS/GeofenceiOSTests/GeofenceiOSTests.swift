//
//  GeofenceiOSTests.swift
//  GeofenceiOSTests
//
//  Created by Mwai Banda on 5/23/22.
//

import XCTest
@testable import GeofenceiOS

class GeofenceiOSTests: XCTestCase {
    var sut: LocationController!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LocationController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGeofencedLocations() throws {
        let locations = sut.geofencedLocations
        XCTAssertNotEqual(locations, [Location]())
    }

    func testTimeFormat() throws {
        let time = sut.getCurrentTime()
        XCTAssertEqual(time.count, 5)
    }
    
    func testPerformanceExample() throws {
        self.measure {
            sut.monitorGeofencedLocations()
        }
    }

}
