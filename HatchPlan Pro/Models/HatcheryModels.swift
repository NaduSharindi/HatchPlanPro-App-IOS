//
//  HatcheryModels.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import Foundation

enum UserRole: String, Codable {
    case supervisor = "Supervisor"
    case manager = "Manager"
}

struct User: Identifiable, Codable {
    let id = UUID()
    let fullName: String
    let jobTitle: String
    let employeeId: String
    let facilityLocation: String
    let role: UserRole
}

struct Batch: Identifiable, Codable {
    let id: String
    let breed: String
    let targetEggSet: Int
    let hatchDate: Date
    let approvalStatus: String
    let progress: Double
}

struct SensorData: Identifiable, Codable {
    let id = UUID()
    let temperature: Double
    let humidity: Double
    let timestamp: Date
}
