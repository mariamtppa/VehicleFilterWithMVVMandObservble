//
//  FleetViewModelTest.swift
//  iOS-assignmentTests
//
//  Created by Mariam Abdulkareem  on 16/12/2021.
//

import XCTest
@testable import iOS_assignment

class FleetViewModelTests: XCTestCase {
    private var userDefaultsMock: UserDefaults!
    private var sut: FleetViewModelProtocol!
    
    override func setUp() {
        
        userDefaultsMock = UserDefaults(suiteName: #file)
        userDefaultsMock.removePersistentDomain(forName: #file)
        
        sut = FleetViewModel(defaults: userDefaultsMock)
    }
    
    override func tearDown() {
        userDefaultsMock = nil
        sut = nil
    }

    
}
