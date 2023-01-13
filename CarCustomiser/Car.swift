//
//  Car.swift
//  CarCustomiser
//
//  Created by Ravindra Tummuru on 11/01/2023.
//

import Foundation

struct Car {
    let make: String
    let model: String
    var topSpeed: Int
    var acceleration: Double
    var handling: Int
    
    func displayStats() -> String {
        var output = ""
        output += "Make: \(self.make) \n"
        output += "Model: \(self.model) \n"
        output += "Top Speed: \(self.topSpeed)mph \n"
        output += "Acceleration (0-60): \(self.acceleration) \n"
        output += "Handling: \(self.handling)"
        return output
    }
}
