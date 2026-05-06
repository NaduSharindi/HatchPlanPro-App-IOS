//
//  SupervisorDashboardView.swift.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

struct SupervisorDashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        ZStack {
            // Light gray background for the app
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Main Scrollable Content
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // 1. HEADER
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                            
                            VStack(alignment: .leading) {
                                Text("Good Morning,")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Hasintha!") // Or use viewModel.currentUser.fullName
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "bell")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        // 2. ENVIRONMENT OVERVIEW CARD
                        VStack(spacing: 16) {
                            HStack {
                                Text("Environment Overview")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                HStack(spacing: 4) {
                                    Circle().frame(width: 8, height: 8).foregroundColor(.green)
                                    Text(viewModel.currentSensor.status)
                                        .font(.caption)
                                        .foregroundColor(.green)
                                }
                            }
                            
                            HStack(spacing: 20) {
                                // Temp
                                HStack {
                                    Image(systemName: "thermometer")
                                        .foregroundColor(.orange)
                                        .font(.title2)
                                    VStack(alignment: .leading) {
                                        Text("Avg. Temp")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text("\(viewModel.currentSensor.temperature, specifier: "%.1f")°C")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Humidity
                                HStack {
                                    Image(systemName: "drop.fill")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                    VStack(alignment: .leading) {
                                        Text("Avg. Humidity")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text("\(viewModel.currentSensor.humidity, specifier: "%.1f")%")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(Color(red: 0.1, green: 0.1, blue: 0.12)) // Dark Figma Color
                        .cornerRadius(16)
                        .padding(.horizontal)
                        
                        // 3. ACTIVE BATCHES SECTION
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Active Batches")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("View All") {
                                    // Action
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                            
                            if viewModel.isLoading {
                                ProgressView().frame(maxWidth: .infinity)
                            } else {
                                ForEach(viewModel.activeBatches) { batch in
                                    FigmaBatchCardView(batch: batch)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 100) // Space for custom tab bar
                }
                
                // 4. CUSTOM BOTTOM NAVIGATION BAR
                HStack {
                    Spacer()
                    TabBarIcon(icon: "house.fill", isSelected: true)
                    Spacer()
                    TabBarIcon(icon: "chart.bar", isSelected: false)
                    Spacer()
                    // Center Add Button
                    ZStack {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 50, height: 50)
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .offset(y: -15)
                    Spacer()
                    TabBarIcon(icon: "message", isSelected: false)
                    Spacer()
                    TabBarIcon(icon: "person", isSelected: false)
                    Spacer()
                }
                .padding(.top, 15)
                .padding(.bottom, 25)
                .background(Color.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

// MARK: - Subcomponents to keep code clean

struct FigmaBatchCardView: View {
    let batch: Batch
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(batch.id)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.orange.opacity(0.15))
                    .cornerRadius(8)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("Day \(batch.currentDay) of \(batch.totalDays)")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            
            // Custom Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 8)
                        .foregroundColor(Color(UIColor.systemGray5))
                    
                    Capsule()
                        .frame(width: geometry.size.width * CGFloat(batch.progress), height: 8)
                        .foregroundColor(.orange)
                }
            }
            .frame(height: 8)
            
            HStack {
                Text("Next Phase: ")
                    .foregroundColor(.secondary)
                    .font(.subheadline) +
                Text(batch.nextPhase)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct TabBarIcon: View {
    let icon: String
    let isSelected: Bool
    
    var body: some View {
        Image(systemName: icon)
            .font(.title2)
            .foregroundColor(isSelected ? .blue : .gray)
    }
}

// Helper to round specific corners for the Tab Bar
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}