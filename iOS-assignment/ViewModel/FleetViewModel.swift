//
//  FeleetViewModel.swift
//  iOS-assignment
//
//  Created by Mariam Abdulkareem  on 15/12/2021.
//

import Foundation
import RxSwift
import RxCocoa
import AssignmentUtility


protocol FleetViewModelProtocol {
    var checkUserDefaults: Observable<Bool?> { get }
    var isError: Observable<Bool?> { get }
    var isFiltered: Observable<Bool?> { get }
    func checkUserDefaultsContent()
    func getVehicleData()
    var incomingVehicleData: [Vehicle] { get }
    func mapScooterColorToVehicle(color: String) -> String
    func filterVehicleListByScooterColors()
}

class FleetViewModel: FleetViewModelProtocol {
    
    var checkUserDefaults: Observable<Bool?> = Observable(nil)
    let disposeBag = DisposeBag()
    let accessRequestFunction = AssignmentUtility.self
    var isError: Observable<Bool?> = Observable(nil)
    var isFiltered: Observable<Bool?> = Observable(nil)
    var incomingVehicleData: [Vehicle] = []
    var backupVehicleData: [Vehicle] = []
    
    let defaults: UserDefaults
    init(defaults: UserDefaults = UserDefaults.standard){
        self.defaults = defaults
    }
    
    func checkUserDefaultsContent() {
        guard let retrievedSwitchStatuses = fetchActiveVehicleColors() else {return}
        
        if !retrievedSwitchStatuses[0] && !retrievedSwitchStatuses[1] && !retrievedSwitchStatuses[2] && !retrievedSwitchStatuses[3] {
            checkUserDefaults.value = false
        } else {
            checkUserDefaults.value = true
        }
        
        
    }
    
    private func fetchActiveVehicleColors() -> [Bool]? {
        defaults.array(forKey: Constants.switchStatusKey) as? [Bool]
    }
    
    func getVehicleData() {
        
        accessRequestFunction.requestVehiclesData().asObservable().subscribe(onNext: {
            result in
            do {
                let vehicleData = try JSONDecoder().decode(VehicleModel.self, from: result)
                self.backupVehicleData = vehicleData.vehicles
                self.isError.value = false
                if (self.fetchActiveVehicleColors() != nil) {
                    self.filterVehicleListByScooterColors()
                } else {
                    self.incomingVehicleData = self.backupVehicleData
                    self.isError.value = false
                }
            } catch {
                print(error)
            }
            
        }, onError: {
            _ in
            self.isError.value = true
        }
        ).disposed(by: disposeBag)
    }
    
    func filterVehicleListByScooterColors() {
        guard let stateOfSwitches = fetchActiveVehicleColors() else
        { incomingVehicleData = backupVehicleData
            isError.value = false
            
            isFiltered.value = false
            return
        }
        if !stateOfSwitches[0] && !stateOfSwitches[1] && !stateOfSwitches[2] && !stateOfSwitches[3] {
            incomingVehicleData = backupVehicleData
            isError.value = false
            isFiltered.value = false
            
        } else {
            let filteredVehicleList = backupVehicleData.filter { vehicle in
                if stateOfSwitches[0] && vehicle.color == Constants.ScooterColors.redGreen {
                    return true
                }
                if stateOfSwitches[1] && vehicle.color == Constants.ScooterColors.blueRed {
                    return true
                }
                if stateOfSwitches[2] && vehicle.color == Constants.ScooterColors.pinkYellow {
                    return true
                }
                if stateOfSwitches[3] && vehicle.color == Constants.ScooterColors.yellowBlue {
                    return true
                }
                return false
            }
            incomingVehicleData = filteredVehicleList
            isError.value = false
            isFiltered.value = true
        }
        
    }
    
    //MARK: - Mapping Scooter Color To Vehicle
    func mapScooterColorToVehicle(color: String) -> String {
        var colorString = color
        let firstLetter = colorString.removeFirst()
        return firstLetter.lowercased() + colorString + "Scooter"
        
    }
    
}


