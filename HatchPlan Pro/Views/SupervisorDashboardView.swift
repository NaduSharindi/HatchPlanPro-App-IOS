//
//  SupervisorDashboardView.swift.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

struct SupervisorDashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    // Using our mock supervisor directly for the UI build
    private let mockUser = User(fullName: "Nimesha Fernando", firstName: "Nimesha", jobTitle: "Supervisor", employeeId: "HP-2024", facilityLocation: "Main", role: .supervisor)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Very light gray background from Figma
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Syncing Hatchery...")
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 1. Header
                        DashboardHeaderView(user: mockUser)
                        
                        // 2. Quick Actions
                        QuickActionButtons()
                        
                        // 3. Active Batches Horizontal List
                        VStack(spacing: 12) {
                            HStack {
                                Text("Active Batches")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("See All")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.activeBatches) { batch in
                                        BatchCardView(batch: batch)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10) // Shadow breathing room
                            }
                        }
                        
                        // 4. Live Sensors Grid
                        VStack(spacing: 12) {
                            HStack {
                                Text("Live Sensors")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 20)
                            
                            HStack(spacing: 15) {
                                SensorMetricCard(title: "Temperature", value: "\(viewModel.currentSensor.temperature, specifier: "%.1f")°C", iconName: "thermometer.medium", iconColor: .red)
                                SensorMetricCard(title: "Humidity", value: "\(viewModel.currentSensor.humidity, specifier: "%.0f")%", iconName: "drop.fill", iconColor: .blue)
                                SensorMetricCard(title: "CO2 Level", value: "\(viewModel.currentSensor.co2Level, specifier: "%.1f")%", iconName: "wind", iconColor: .gray)
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        // Spacer to lift content above the bottom nav bar
                        Spacer(minLength: 80)
                    }
                    .padding(.top, 10)
                }
            }
            
            // 5. Custom Bottom Navigation Bar
            CustomBottomNavBar()
        }
        .navigationBarHidden(true) // Hide the default navigation bar since we built a custom one
    }
}