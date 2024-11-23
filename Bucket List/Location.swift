//
//  Location.swift
//  Bucket List
//
//  Created by Pau Valverde Molina on 11/19/24.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    //id needs to be var as we have a custon equatable function to only compare the id of locations, once a change has been to location we asing new id to trigger saving and update of that location.
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    //Example location for previews
    static var example: Location {
        Location(id: UUID(), name: "Kyoto", description: "This is an example location of Kyoto", latitude: 35.67279, longitude: -136.69082)
    }
    #endif
    
    //If UUID is identical, two locations are the same, no need for equatable to check on all the other strcu parameters.
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
