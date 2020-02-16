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
    var dimensions : String
    var location : String
    
    init(dimensions: String, location: String) {
        self.dimensions = dimensions
        self.location = location
    }
}
