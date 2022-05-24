//
//  LocationControllet.swift
//  GeofenceiOS
//
//  Created by Mwai Banda on 5/24/22.
//

import Foundation

import Foundation
import CoreLocation
import SwiftUI

class LocationController: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager: CLLocationManager!
    @Published  var showAlert = false
    private(set) var CLGeoCoder : CLGeocoder
    @Published  var currentLocation: CLLocationCoordinate2D!

    
    override init() {
        CLGeoCoder = CLGeocoder()
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Authorized")
            manager.requestLocation()
        case.denied:
            print("Denied")
        default:
            print("Unknown")
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func hasLocationAuthorization() -> Bool {
        var isEnabled = false
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    isEnabled = false
                case .authorizedAlways, .authorizedWhenInUse:
                    isEnabled = true
                @unknown default:
                break
            }
            } else {
                print("Location services are not enabled")
        }
        return isEnabled
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: \(String(describing: locations.first?.description)))")
            currentLocation = locations.first?.coordinate
              }
    }
    func monitorRegionAtLocation(center: CLLocationCoordinate2D, identifier: String) {
            
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
               
                let region = CLCircularRegion(center: center,
                     radius: 200, identifier: identifier)
                region.notifyOnEntry = true
                region.notifyOnExit = true
           
                locationManager.startMonitoring(for: region)
            }
     }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Delegate: didStartMonitoringFor" + region.identifier)
    }
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            
            showAlert = true
            if UIApplication.shared.applicationState == .active {
                print("Entered " +  region.identifier)

            } else {
                
              let body = "You've Entered " + region.identifier
              let notificationContent = UNMutableNotificationContent()
              notificationContent.body = body
              notificationContent.sound = .default
              notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
              let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
              let request = UNNotificationRequest(
                identifier: "location_change",
                content: notificationContent,
                trigger: trigger)
              UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                  print("Error: \(error)")
                }
              }
            }
            
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            showAlert = false

            if UIApplication.shared.applicationState == .active {
                print("Left " +  region.identifier)

            } else {
                
              let body = "You left " + region.identifier
              let notificationContent = UNMutableNotificationContent()
              notificationContent.body = body
              notificationContent.sound = .default
              notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
              let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
              let request = UNNotificationRequest(
                identifier: "location_change",
                content: notificationContent,
                trigger: trigger)
              UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                  print("Error: \(error)")
                }
              }
            }
    }
    
}
