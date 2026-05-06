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

// MARK: - Batch History List Row
struct BatchHistoryRowView: View {
    let batch: Batch
    
    var body: some View {
        HStack {
            // Left Column: Details
            VStack(alignment: .leading, spacing: 8) {
                Text("Batch \(batch.id)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("\(batch.breed) - \(batch.targetEggSet.formatted()) Eggs")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Status & Date
                HStack(spacing: 6) {
                    Text(batch.approvalStatus)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(batch.approvalStatus == "Hatched" ? .green : .red)
                    
                    Text("-")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(batch.completionDate ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer(minLength: 20)
            
            // Right Column: Rating & Arrow
            VStack(alignment: .trailing, spacing: 15) {
                if let rating = batch.rating {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                            .fontWeight(.bold)
                        Text("/ 5.0")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                }
                
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

// MARK: - Profile Summary Card
struct ProfileSummaryCard: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 16) {
            // Large Avatar
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 70, height: 70)
                .overlay(
                    Text(String(user.firstName.prefix(1)))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                )
            
            // User Details
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(user.jobTitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("ID: \(user.employeeId) • \(user.facilityLocation)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Reusable Settings Row
struct SettingsRowView: View {
    let iconName: String
    let title: String
    let iconColor: Color
    var isDestructive: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon with colored background
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 36, height: 36)
                
                Image(systemName: iconName)
                    .foregroundColor(iconColor)
                    .font(.system(size: 16, weight: .semibold))
            }
            
            Text(title)
                .font(.body)
                .fontWeight(isDestructive ? .semibold : .regular)
                .foregroundColor(isDestructive ? .red : .primary)
            
            Spacer()
            
            if !isDestructive {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Notification Row Component
struct NotificationRowView: View {
    let notification: AppNotification
    
    // Dynamically set the icon and colors based on the type
    var styleOptions: (icon: String, color: Color, bg: Color) {
        switch notification.type {
        case .critical: return ("exclamationmark.triangle.fill", .red, .red.opacity(0.1))
        case .warning: return ("exclamationmark.circle.fill", .orange, .orange.opacity(0.1))
        case .info: return ("info.circle.fill", .blue, .blue.opacity(0.1))
        case .success: return ("checkmark.circle.fill", .green, .green.opacity(0.1))
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Icon Background
            ZStack {
                Circle()
                    .fill(styleOptions.bg)
                    .frame(width: 48, height: 48)
                
                Image(systemName: styleOptions.icon)
                    .foregroundColor(styleOptions.color)
                    .font(.system(size: 20))
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(notification.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(notification.timeAgo)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Text(notification.message)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2) // Keeps the UI tidy
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Filter Pill Component
struct FilterPillView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .medium)
                .foregroundColor(isSelected ? .white : .gray)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
                .cornerRadius(20)
        }
    }
}