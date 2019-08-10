//
//  CityResponseMapper.swift
//  MeteoApp
//
//  Created by Martin Prot on 10/08/2019.
//  Copyright © 2019 appricot media. All rights reserved.
//

import MPModelKit
import CoreData

extension City: Identifiable {
    public static var identifierKeyPath: String {
        return "objectId"
    }
}

class CityResponseMapper: CoreDataResponseMapper<City> {

    enum Key: String, ServiceKey {
        case identifier = "identifier"
        case name = "name"
        case latitude = "location.latitude"
        case longitude = "location.longitude"
        case countryCode = "countryCode"
    }

    static func process(jsonObject: Any, objectContext moc: NSManagedObjectContext) throws -> City {
        guard
            let json = jsonObject as? [String: Any],
            let identifier: Int64 = json.key(Key.identifier),
            let name: String = json.key(Key.name),
            let countryCode: String = json.key(Key.countryCode),
            let latitude: Double = json.key(Key.latitude),
            let longitude: Double = json.key(Key.longitude)
            else {
                throw ResponseMapperError.missingAttribute
        }
        let city: City = try moc.newOrExistingObject(identifiedBy: identifier)
        city.name = name
        city.countryCode = countryCode
        city.latitude = latitude
        city.longitude = longitude
        return city
    }
}
