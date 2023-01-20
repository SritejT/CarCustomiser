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
    @State private var selectorEnabled = true
    @State private var remainingFunds = 1000
    @State private var remainingTime = 30 {
        didSet {
            if remainingTime == 0 {
                selectorEnabled = false
            }
        }
    }
    
    var exhaustPackageEnabled: Bool {
        return (remainingTime > 0) ? (exhaustPackage ? true : remainingFunds >= 500 ? true : false) : false
    }
    
    var tiresPackageEnabled: Bool {
        return (remainingTime > 0) ? (tiresPackage ? true : remainingFunds >= 500 ? true : false) : false
    }
    
    var turboBoosterEnabled: Bool {
        return (remainingTime > 0) ? (turboBooster ? true : remainingFunds >= 1000 ? true : false) : false
    }
    
    var engineUpgradeEnabled: Bool {
        return (remainingTime > 0) ? (engineUpgrade ? true : remainingFunds >= 1000 ? true : false) : false
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: { self.exhaustPackage },
            set: { newValue in self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
            }
        )
        let tiresPackageBinding = Binding<Bool> (
            get: { self.tiresPackage },
            set: { newValue in self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500
                }
            }
        )
        let turboBoosterBinding = Binding<Bool> (
            get: { self.turboBooster },
            set: { newValue in self.turboBooster = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 1
                    remainingFunds -= 1000
                } else {
                    starterCars.cars[selectedCar].acceleration += 1
                    remainingFunds += 1000
                }
            }
        )
        let engineUpgradeBinding = Binding<Bool> (
            get: { self.engineUpgrade },
            set: { newValue in self.engineUpgrade = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 1
                    starterCars.cars[selectedCar].topSpeed += 10
                    remainingFunds -= 1000
                } else {
                    starterCars.cars[selectedCar].acceleration += 1
                    starterCars.cars[selectedCar].topSpeed -= 10
                    remainingFunds += 1000
                }
            }
        )
        VStack {
            Text("\(remainingTime)")
                .onReceive(timer, perform: { _ in
                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    }
                })
                .foregroundColor(.red)
            Form {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(starterCars.cars[selectedCar].displayStats())")
                        .padding()
                    Button("Next Car", action: {
                        selectedCar += 1
                        resetDisplay()
                    })
                        .disabled(!selectorEnabled)
                }
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(!exhaustPackageEnabled)
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(!tiresPackageEnabled)
                    Toggle("Turbo Booster (Cost: 1000)", isOn: turboBoosterBinding)
                        .disabled(!turboBoosterEnabled)
                    Toggle("Engine Upgrade (Cost: 1000)", isOn: engineUpgradeBinding)
                        .disabled(!engineUpgradeEnabled)
                }
            }
            Text("Remaining Funds: \(remainingFunds)")
                .foregroundColor(.red)
                .baselineOffset(20)
        }
    }
    func resetDisplay() {
        remainingFunds = 1000
        exhaustPackage = false
        tiresPackage = false
        turboBooster = false
        engineUpgrade = false
        starterCars = StarterCars()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
