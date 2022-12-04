//
//  PlaceAnnotation.swift
//  NearbyLocation
//
//  Created by Ikhwan on 04/12/22.
//

import Foundation
import MapKit

final class PlaceAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
}
