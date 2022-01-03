//
//  VehicleFilterViewModel.swift
//  iOS-assignment
//
//  Created by Mariam Abdulkareem  on 15/12/2021.
//


import Foundation

protocol FilterVehicleViewModelProtocol {
    var retrieveSwitchStates: Observable<[Bool]?> { get }
    func getSwitchState()
    func updateSwitchState(updatedSwitchArray: [Bool])
}

class FilterVehicleViewModel: FilterVehicleViewModelProtocol {
    var retrieveSwitchStates: Observable<[Bool]?> = Observable(nil)
    
    let defaults: UserDefaults
    init(defaults: UserDefaults = UserDefaults.standard){
        self.defaults = defaults
    }
    func getSwitchState() {
        if defaults.object(forKey: Constants.switchStatusKey) != nil {
            retrieveSwitchStates.value = defaults.array(forKey: Constants.switchStatusKey) as? [Bool] ?? [Bool]()
            
        }
    }
    
    func updateSwitchState(updatedSwitchArray: [Bool]) {
        defaults.set(updatedSwitchArray, forKey: Constants.switchStatusKey)
    }  
}


