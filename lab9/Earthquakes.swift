//
//  Earthquakes.swift
//  lab9
//
//  Created by Arin Houck on 11/16/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import Foundation

class Earthquakes {
    var rows: [Earthquake] = []
}

class Earthquake {
    private var datetime: String
    private var depth: Float
    private var longitude: Float
    private var latitude: Float
    private var magnitude: Float
    
    enum EarthquakeFields: String {
        case DateTime = "datetime"
        case Depth = "depth"
        case Longitude = "lng"
        case Latitude = "lat"
        case Magnitude = "magnitude"
    }
    
    required init (earthquake: NSDictionary)
    {
        self.datetime = earthquake[Earthquake.EarthquakeFields.DateTime.rawValue] as! String
        self.depth = earthquake[Earthquake.EarthquakeFields.Depth.rawValue] as! Float
        self.longitude = earthquake[Earthquake.EarthquakeFields.Longitude.rawValue] as! Float
        self.latitude = earthquake[Earthquake.EarthquakeFields.Latitude.rawValue] as! Float
        self.magnitude = earthquake[Earthquake.EarthquakeFields.Magnitude.rawValue] as! Float
    }
    
    internal func getMagnitude() -> Float
    {
        return magnitude
    }
    
    internal func getLongitude() -> Float
    {
        return longitude
    }
    
    internal func getLatitude() -> Float
    {
        return latitude
    }
}