//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Ravindra Tummuru on 11/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet {
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var turboBooster = false
    @State private var engineUpgrade = false
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: { self.exhaustPackage },
            set: { newValue in self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                }
            }
        )
        let tiresPackageBinding = Binding<Bool> (
            get: { self.tiresPackage },
            set: { newValue in self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                }
            }
        )
        let turboBoosterBinding = Binding<Bool> (
            get: { self.turboBooster },
            set: { newValue in self.turboBooster = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 1
                } else {
                    starterCars.cars[selectedCar].acceleration += 1
                }
            }
        )
        let engineUpgradeBinding = Binding<Bool> (
            get: { self.engineUpgrade },
            set: { newValue in self.engineUpgrade = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 1
                    starterCars.cars[selectedCar].topSpeed += 10
                } else {
                    starterCars.cars[selectedCar].acceleration += 1
                    starterCars.cars[selectedCar].topSpeed -= 10
                    
                }
            }
        )
        Form {
            VStack(alignment: .leading, spacing: 20) {
                Text("\(starterCars.cars[selectedCar].displayStats())")
                    .padding()
                Button("Next Car", action: {
                    selectedCar += 1
                })
            }
            Section {
                Toggle("Exhaust Package", isOn: exhaustPackageBinding)
                Toggle("Tires Package", isOn: tiresPackageBinding)
                Toggle("Turbo Booster", isOn: turboBoosterBinding)
                Toggle("Engine Upgrade", isOn: engineUpgradeBinding)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
