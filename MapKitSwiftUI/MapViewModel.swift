//
//  MapViewModel.swift
//  MapKitSwiftUI
//
//  Created by Pranav Shashikant Deshpande on 6/21/22.
//

import Foundation
import MapKit

// Adding content view model - all location stuff - location manager - handles all location stuff

// If multiple screens need location - create a separate file - arch
// This class handles Location Manager
class ContentViewModel: NSObject,ObservableObject, CLLocationManagerDelegate {
    // Need to update the region variable to show the users location, so have to configure the region variable inside the ContentViewModel class
    // when this region changes - the UI changes
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3315, longitude: -121.891), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    // to use a users location - need location manager to do some stuff.
    // A variable which belongs to class CLLocationManager - Use this create your locationManager under some conditions
    var locationManager: CLLocationManager?
    // check if location is turned ON:
     func checkIfLocationisEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            // if its true, then create your location manager
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
        } else {
            print("Location is Off")
        }
    }
    
    private func checkLocationAuth() {
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus {
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            // update our variable region with proper lat and long
        case .authorizedWhenInUse:
            // update our variable region with proper lat and long
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
}

