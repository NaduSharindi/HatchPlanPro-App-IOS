import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: AppRouter
    @State private var currentTab = 3 // 3 represents the Person/Settings tab
    
    // Toggles for user preferences
    @State private var pushNotificationsEnabled = true
    @State private var biometricsEnabled = true
    @State private var darkModeEnabled = false
    
    // Fetching the user from our centralized Mock Data Service
    @State private var currentUser: User?
    @State private var isLoading = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            if isLoading {
                Spacer()
                ProgressView("Loading Profile...")
                Spacer()
            } else if let user = currentUser {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 1. Header
                        HStack {
                            Text("Settings")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        // 2. Profile Card
                        ProfileSummaryCard(user: user)
                            .padding(.horizontal, 20)
                        
                        // 3. Settings Sections using SwiftUI Forms/Lists styling
                        VStack(spacing: 0) {
                            
                            // PREFERENCES SECTION
                            VStack(alignment: .leading, spacing: 0) {
                                Text("PREFERENCES")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 8)
                                
                                VStack(spacing: 0) {
                                    Toggle(isOn: $pushNotificationsEnabled) {
                                        SettingsRowView(iconName: "bell.fill", title: "Push Notifications", iconColor: .blue)
                                    }
                                    .tint(.blue)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    
                                    Divider().padding(.leading, 60)
                                    
                                    Toggle(isOn: $darkModeEnabled) {
                                        SettingsRowView(iconName: "moon.fill", title: "Dark Mode", iconColor: .indigo)
                                    }
                                    .tint(.blue)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                }
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .padding(.horizontal, 20)
                            }
                            .padding(.bottom, 24)
                            
                            // SECURITY SECTION
                            VStack(alignment: .leading, spacing: 0) {
                                Text("SECURITY")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 8)
                                
                                VStack(spacing: 0) {
                                    Toggle(isOn: $biometricsEnabled) {
                                        SettingsRowView(iconName: "faceid", title: "Biometric Login", iconColor: .green)
                                    }
                                    .tint(.green)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    
                                    Divider().padding(.leading, 60)
                                    
                                    Button(action: { /* Change Password Action */ }) {
                                        SettingsRowView(iconName: "lock.fill", title: "Change Password", iconColor: .orange)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 8)
                                    }
                                }
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .padding(.horizontal, 20)
                            }
                            .padding(.bottom, 24)
                            
                            // ACCOUNT ACTION SECTION
                            VStack(alignment: .leading, spacing: 0) {
                                VStack(spacing: 0) {
                                    Button(action: {
                                        // LOGOUT LOGIC
                                        router.navigate(to: .signIn)
                                    }) {
                                        SettingsRowView(iconName: "rectangle.portrait.and.arrow.right", title: "Log Out", iconColor: .red, isDestructive: true)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 8)
                                    }
                                }
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        // Spacer to lift content above the bottom nav bar
                        Spacer(minLength: 100)
                    }
                }
            }
            
            // 4. Custom Bottom Navigation Bar
            CustomBottomNavBar(selectedTab: $currentTab)
        }
        .navigationBarHidden(true)
        .onAppear {
            // Fetch the mock user data when the view loads
            HatcheryDataService.shared.fetchMockUser(for: .supervisor) { user in
                self.currentUser = user
                self.isLoading = false
            }
        }
    }
}