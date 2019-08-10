//
//  MKCoordinateRegion+Utils.swift
//  mpkit
//
//  Created by Martin Prot on 19/12/2017.
//  Copyright © 2017 Appricot media. All rights reserved.
//

import MapKit

extension MKCoordinateRegion {

	public init?(containing annotations: [MKAnnotation]) {
		guard let firstAnn = annotations.first else { return nil }
		var minLat = firstAnn.coordinate.latitude
		var minLong = firstAnn.coordinate.longitude
		var maxLat = firstAnn.coordinate.latitude
		var maxLong = firstAnn.coordinate.longitude
		annotations.forEach {
			if $0.coordinate.latitude < minLat {
				minLat = $0.coordinate.latitude
			}
			if $0.coordinate.longitude < minLong {
				minLong = $0.coordinate.longitude
			}
			if $0.coordinate.latitude > maxLat {
				maxLat = $0.coordinate.latitude
			}
			if $0.coordinate.longitude > maxLong {
				maxLong = $0.coordinate.longitude
			}
		}
		let topLeft = CLLocationCoordinate2D(latitude: minLat, longitude: minLong)
		let bottomRight = CLLocationCoordinate2D(latitude: maxLat, longitude: maxLong)
		let a = MKMapPoint(topLeft)
		let b = MKMapPoint(bottomRight)
		let mapRect = MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
		let region = MKCoordinateRegion.init(mapRect)
		self.init(center: region.center, span: MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta*1.2, longitudeDelta: region.span.longitudeDelta*1.2))
	}
}
