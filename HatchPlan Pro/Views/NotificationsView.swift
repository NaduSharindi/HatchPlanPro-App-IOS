import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = DashboardViewModel()
    
    // Filter State
    @State private var selectedFilter = "All"
    let filters = ["All", "Alerts", "Updates"]
    
    // Computed property to handle the filter logic
    var filteredNotifications: [AppNotification] {
        switch selectedFilter {
        case "Alerts":
            return viewModel.notifications.filter { $0.type == .critical || $0.type == .warning }
        case "Updates":
            return viewModel.notifications.filter { $0.type == .info || $0.type == .success }
        default:
            return viewModel.notifications // "All"
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                // 1. Header with Back Button
                HStack {
                    Button(action: {
                        // Normally this would pop the view, or you can route back to dashboard
                        // e.g., router.navigate(to: .loggedIn)
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    
                    Text("Notifications")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Mark all as read button
                    Button(action: { /* Mark all logic */ }) {
                        Image(systemName: "checkmark.circle")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // 2. Filter Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(filters, id: \.self) { filter in
                            FilterPillView(
                                title: filter,
                                isSelected: selectedFilter == filter
                            ) {
                                withAnimation { selectedFilter = filter }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                // 3. Scrollable List of Notifications
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Fetching Alerts...")
                    Spacer()
                } else if filteredNotifications.isEmpty {
                    Spacer()
                    VStack {
                        Image(systemName: "bell.slash")
                            .font(.system(size: 40))
                            .foregroundColor(.gray.opacity(0.5))
                            .padding(.bottom, 8)
                        Text("No notifications here")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(filteredNotifications) { notification in
                                NotificationRowView(notification: notification)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            // Ensure the data is loaded from the service
            viewModel.fetchData()
        }
    }
}