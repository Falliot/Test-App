//
//  Dimentions.swift
//  Test app
//
//  Created by Anton on 2/14/20.
//  Copyright © 2020 falli_ot. All rights reserved.
//

import Foundation

/**
 
This is a structure for JSON
 
## Parameters
 
 1. dimensions - for our image dimensions
 2. location - for the current location
 
 */

struct Dimensions : Codable
{
    /// A string for dimensions in a form:  Ex. 100 x 100
    
    var dimensions : String
    
    /// A string for location in a form:  latitude x longtitude
    
    var location : String
    
    ///An initializer that takes two arguments dimensions and location
    
    init(dimensions: String, location: String) {
        self.dimensions = dimensions
        self.location = location
    }
}
