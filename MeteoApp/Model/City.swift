//
//  City.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import CoreData
import MapKit

@objc(City)
class City: NSManagedObject {
    @NSManaged public var objectId: Int64
    @NSManaged public var name: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
}

extension City {
    var location: CLLocation? {
        guard self.latitude != 0, self.longitude != 0 else { return .none }
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}
