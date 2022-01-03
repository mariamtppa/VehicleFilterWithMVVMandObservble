//
//  VehicleModel.swift
//  iOS-assignment
//
//  Created by Mariam Abdulkareem  on 12/12/2021.
//

import Foundation

struct VehicleModel: Codable {
    let vehicles: [Vehicle]
}

// MARK: - Vehicle
struct Vehicle: Codable {
    var color: String
    let qrURL: String
    let identificationCode: String
}
