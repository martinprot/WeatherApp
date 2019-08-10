//
//  MPMapCenterer.swift
//  mpkit
//
//  Created by Martin Prot on 12/12/2017.
//  Copyright © 2017 Qosi. All rights reserved.
//

import Foundation
import MapKit

public class MPMapCenterer: NSObject, CLLocationManagerDelegate {
	let mapView: MKMapView?
	let locationManager = CLLocationManager()
	let displayedSpan: CLLocationDegrees
	
	public init(mapView: MKMapView?, span: CLLocationDegrees) {
		self.mapView = mapView
		self.displayedSpan = span
	}
	
	public func startCenteringUser() {
		self.mapView?.showsUserLocation = true
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		switch CLLocationManager.authorizationStatus() {
		case .authorizedWhenInUse, .authorizedAlways:
			locationManager.startUpdatingLocation()
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
		default:
			break
		}
	}
	
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		self.mapView?.setCenter(location.coordinate, animated: true)
		self.mapView?.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: self.displayedSpan, longitudeDelta: self.displayedSpan))
		
		self.locationManager.stopUpdatingLocation()
	}
}


