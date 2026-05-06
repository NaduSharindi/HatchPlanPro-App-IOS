import SwiftUI

// MARK: - Custom Header
struct DashboardHeaderView: View {
    let user: User
    
    var body: some View {
        HStack {
            // Hamburger Menu Placeholder
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("Hello, \(user.firstName)!")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Thursday, 22 April") // You can make this dynamic with DateFormatter later
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Profile Avatar Placeholder
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 40)
                .overlay(Image(systemName: "person.fill").foregroundColor(.gray))
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

// MARK: - Quick Action Buttons
struct QuickActionButtons: View {
    var body: some View {
        HStack(spacing: 15) {
            // Scan Biometrics Button
            Button(action: {}) {
                HStack {
                    Image(systemName: "faceid")
                        .font(.title3)
                    Text("Scan Biometrics")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            }
            
            // Log New Batch Button
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                    Text("Log New Batch")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.orange)
                .cornerRadius(12)
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Active Batch Card
struct BatchCardView: View {
    let batch: Batch
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Batch \(batch.id)")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text(batch.approvalStatus)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(batch.approvalStatus == "Approved" ? .green : .orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(batch.approvalStatus == "Approved" ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
                    .cornerRadius(8)
            }
            
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
                
                // Custom Progress Bar
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
        .padding()
        .frame(width: 260)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Live Sensor Metric Card
struct SensorMetricCard: View {
    let title: String
    let value: String
    let iconName: String
    let iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(iconColor)
                .padding(10)
                .background(iconColor.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Bottom Navigation Bar
struct CustomBottomNavBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
        HStack {
            NavBarItem(iconName: "house.fill", isSelected: selectedTab == 0) { selectedTab = 0 }
            Spacer()
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

struct NavBarItem: View {
    let iconName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? .blue : .gray.opacity(0.6))
        }
    }
}