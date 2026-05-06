//
//  DashboardViewModel.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var activeBatches: [Batch] = []
    @Published var currentSensor: SensorData = SensorData(temperature: 0.0, humidity: 0.0, timestamp: Date())
    @Published var isLoading: Bool = false
    
    init() {
        fetchMockData()
    }
    
    func fetchMockData() {
        isLoading = true
        
        // Simulate a network delay (like Firebase fetching)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // Populate mock sensor data
            self.currentSensor = SensorData(temperature: 37.5, humidity: 58.0, timestamp: Date())
            
            // Populate mock batch data
            self.activeBatches = [
                Batch(id: "#B1024", breed: "Ross 308", targetEggSet: 15000, hatchDate: Date().addingTimeInterval(86400 * 4), approvalStatus: "Approved", progress: 0.92),
                Batch(id: "#B1025", breed: "Cobb 500", targetEggSet: 12000, hatchDate: Date().addingTimeInterval(86400 * 10), approvalStatus: "Pending", progress: 0.45)
            ]
            
            self.isLoading = false
        }
    }
}

