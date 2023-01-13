//
//  CarCustomiserTests.swift
//  CarCustomiserTests
//
//  Created by Ravindra Tummuru on 11/01/2023.
//

import XCTest

class CarCustomiserTests: XCTestCase {

    func testNewCarGivesMeACarWithAllAttributesSet() {
        let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        
        XCTAssertEqual(car.make, "Mazda")
        XCTAssertEqual(car.model, "MX-5")
        XCTAssertEqual(car.topSpeed, 125)
        XCTAssertEqual(car.acceleration, 7.7)
        XCTAssertEqual(car.handling, 5)
    }
    
    func testNewCarDisplaysStats() {
        let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        var expected = "Make: \(car.make) \n"
        expected += "Model: \(car.model) \n"
        expected += "Top Speed: \(car.topSpeed)mph \n"
        expected += "Acceleration (0-60): \(car.acceleration) \n"
        expected += "Handling: \(car.handling)"
        XCTAssertEqual(car.displayStats(), expected)
    }

}
