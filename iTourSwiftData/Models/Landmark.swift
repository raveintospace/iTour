//
//  Landmark.swift
//  iTourSwiftData
//  https://youtu.be/m1H7Q7EM_6Y?si=hCOKAQcNJBjmF3gQ
//  Created by Uri on 3/10/23.
//  Landmarks have relationship with Destination, they are owned by Destination

import Foundation
import SwiftData

@Model
class Landmark {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
