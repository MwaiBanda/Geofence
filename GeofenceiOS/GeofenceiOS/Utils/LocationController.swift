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
    @Published var showAlert = false
    @Published var history = [Visit]()
    let geofencedLocations = [
        Location(name: "Chicago Midway International Airport", latitude: 41.78499686, longitude: -87.751496994),
        Location(name: "O’Hare International Airport", latitude: 41.978611, longitude: -87.904724),
        Location(name: "Shedd Aquarium", latitude: 41.8670292454, longitude: -87.6134396189),
        Location(name: "Nando's Peri Peri Chicken", latitude: 41.90855, longitude: -87.64636)
    ]
    
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
            let location = geofencedLocations.first(where: { $0.latitude == currentLocation.latitude && $0.longitude == currentLocation.longitude})
            history.append(Visit(name: location?.name ?? "", visitationStart: getCurrentTime()))
            print(location as Any)
              }
    }
    func monitorGeofencedLocations() {
        geofencedLocations.forEach { location in
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
               
            let region = CLCircularRegion(center: location.coordinate,
                                          radius: 200, identifier: location.name)
                region.notifyOnEntry = true
                region.notifyOnExit = true
           
                locationManager.startMonitoring(for: region)
            }
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
        history.append(Visit(name: region.identifier, visitationStart: getCurrentTime()))

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
        if !history.isEmpty {
        history[history.lastIndex(where: { $0.name == region.identifier }) ?? 0].visitationEnd = getCurrentTime()
        }
    }
    func getCurrentTime() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm"
           let currentTimeString = dateFormatter.string(from: Date())
           return currentTimeString
       }
       
    
}
