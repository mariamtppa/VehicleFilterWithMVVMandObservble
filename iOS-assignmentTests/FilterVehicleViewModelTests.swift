//
//  VehicleViewTests.swift
//  iOS-assignmentTests
//
//  Created by Mariam Abdulkareem  on 16/12/2021.
//

import XCTest
@testable import iOS_assignment

class FilterVehicleViewModelTests: XCTestCase {
    private var userDefaultsMock: UserDefaults!
    private var sut: FilterVehicleViewModel!
    
    override func setUp() {
        
        userDefaultsMock = UserDefaults(suiteName: #file)
        userDefaultsMock.removePersistentDomain(forName: #file)
        
        sut = FilterVehicleViewModel(defaults: userDefaultsMock)
    }
    
    override func tearDown() {
        userDefaultsMock = nil
        sut = nil
    }
    
    func test_retrieveSwitchStatus() {
        // arrange
        let switchArrayMock = [true, false, true, false]
        userDefaultsMock.set(switchArrayMock, forKey: Constants.switchStatusKey)
        
        // act
        sut.getSwitchState()
        
        // assert
        XCTAssertEqual(sut.retrieveSwitchStates.value, [true, false, true, false])
    }
    
    func testUpdateSwitchStatus() {
        // arrange
        let switchArrayMock = [true, false, true, false]
        
        // act
        sut.updateSwitchState(updatedSwitchArray: switchArrayMock)
        sut.getSwitchState()
        
        // assert
        XCTAssertEqual(sut.retrieveSwitchStates.value, [true, false, true, false])
    }
    
}
