//
//  Dimentions.swift
//  Test app
//
//  Created by Anton on 2/14/20.
//  Copyright © 2020 falli_ot. All rights reserved.
//

import Foundation

struct Dimensions : Codable
{
    var dimensions : String
    var location : String
    
    init(dimensions: String, location: String ) {
        self.dimensions = dimensions
        self.location = location
    }
}
