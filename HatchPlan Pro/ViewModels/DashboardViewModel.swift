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
        fetchData()
    }
    
    func fetchData() {
        isLoading = true
        
        // 1. Ask the service for Sensor Data
        HatcheryDataService.shared.fetchLiveSensorData { [weak self] sensor in
            self?.currentSensor = sensor
            
            // 2. Ask the service for Batch Data
            HatcheryDataService.shared.fetchActiveBatches { [weak self] batches in
                self?.activeBatches = batches
                self?.isLoading = false // Turn off loading spinner when both are done
            }
        }
    }
}