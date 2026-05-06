//
//  DashboardComponents.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

// MARK: - Sensor Card UI
struct SensorCardView: View {
    let sensor: SensorData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("HUMIDITY")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(sensor.humidity, specifier: "%.0f")%")
                    .font(.system(size: 28, weight: .bold))
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("TEMP")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(sensor.temperature, specifier: "%.1f")°C")
                    .font(.system(size: 28, weight: .bold))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

// MARK: - Batch Row UI
struct BatchRowView: View {
    let batch: Batch
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Batch \(batch.id)")
                    .font(.headline)
                Text(batch.breed)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 5) {
                Text("\(Int(batch.progress * 100))% Progress")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(batch.progress > 0.9 ? .green : .blue)
                Text(batch.approvalStatus)
                    .font(.caption)
                    .padding(4)
                    .background(batch.approvalStatus == "Approved" ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                    .cornerRadius(5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// MARK: - Search Bar Component
struct SearchFilterBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 12) {
            // Search Field
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search batches...", text: $searchText)
                    .font(.subheadline)
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            
            // Filter Button
            Button(action: {
                // Filter action
            }) {
                Image(systemName: "slider.horizontal.3")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Vertical Batch List Row
struct BatchListRowView: View {
    let batch: Batch
    
    var body: some View {
        HStack {
            // Left Column: Details & Progress
            VStack(alignment: .leading, spacing: 10) {
                Text("Batch \(batch.id)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("\(batch.breed) - \(batch.targetEggSet.formatted()) Eggs")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Day \(batch.currentDay)")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(Int(batch.progress * 100))%")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Progress Bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule().frame(width: geometry.size.width, height: 6)
                                .foregroundColor(Color.gray.opacity(0.2))
                            Capsule().frame(width: geometry.size.width * CGFloat(batch.progress), height: 6)
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(height: 6)
                }
            }
            
            Spacer(minLength: 20)
            
            // Right Column: Status Badge & Arrow
            VStack(alignment: .trailing, spacing: 15) {
                Text(batch.approvalStatus)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(batch.approvalStatus == "Approved" ? .green : .orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(batch.approvalStatus == "Approved" ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
                    .cornerRadius(8)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - UPDATED: Custom Bottom Navigation Bar
struct CustomBottomNavBar: View {
    @Binding var selectedTab: Int // Now accepts a binding so we can change tabs!
    
    var body: some View {
        HStack {
            NavBarItem(iconName: "house.fill", isSelected: selectedTab == 0) { selectedTab = 0 }
            Spacer()
            // Second tab matches your Figma active state for the Batches list
            NavBarItem(iconName: "calendar", isSelected: selectedTab == 1) { selectedTab = 1 }
            Spacer()
            NavBarItem(iconName: "chart.bar", isSelected: selectedTab == 2) { selectedTab = 2 }
            Spacer()
            NavBarItem(iconName: "person", isSelected: selectedTab == 3) { selectedTab = 3 }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: -5, x: 0, y: -2)
    }
}
