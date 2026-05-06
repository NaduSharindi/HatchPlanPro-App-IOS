import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: AppRouter
    @State private var currentTab = 3 
    @State private var currentUser: User?
    @State private var isLoading = true
    
    var body: some View {
        // 1. Wrap the entire view in a NavigationView for native routing
        NavigationView {
            ZStack(alignment: .bottom) {
                Color(UIColor.systemGray6).ignoresSafeArea()
                
                if isLoading {
                    ProgressView("Loading Profile...")
                } else if let user = currentUser {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            
                            // Profile Card
                            ProfileSummaryCard(user: user)
                                .padding(.horizontal, 20)
                                .padding(.top, 10)
                            
                            // 2. Wrap rows in NavigationLinks
                            VStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("ACCOUNT")
                                        .font(.caption).fontWeight(.bold).foregroundColor(.gray)
                                        .padding(.horizontal, 20).padding(.bottom, 8)
                                    
                                    VStack(spacing: 0) {
                                        NavigationLink(destination: EditProfileView()) {
                                            SettingsRowView(iconName: "person.fill", title: "Edit Profile", iconColor: .blue)
                                        }
                                        .padding(.horizontal, 20).padding(.vertical, 4)
                                        
                                        Divider().padding(.leading, 60)
                                        
                                        NavigationLink(destination: ChangePasswordView()) {
                                            SettingsRowView(iconName: "lock.fill", title: "Change Password", iconColor: .orange)
                                        }
                                        .padding(.horizontal, 20).padding(.vertical, 4)
                                    }
                                    .background(Color.white).cornerRadius(16)
                                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                    .padding(.horizontal, 20)
                                }
                                .padding(.bottom, 24)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("PREFERENCES")
                                        .font(.caption).fontWeight(.bold).foregroundColor(.gray)
                                        .padding(.horizontal, 20).padding(.bottom, 8)
                                    
                                    VStack(spacing: 0) {
                                        NavigationLink(destination: NotificationPreferencesView()) {
                                            SettingsRowView(iconName: "bell.fill", title: "Notification Settings", iconColor: .purple)
                                        }
                                        .padding(.horizontal, 20).padding(.vertical, 4)
                                    }
                                    .background(Color.white).cornerRadius(16)
                                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                    .padding(.horizontal, 20)
                                }
                                .padding(.bottom, 24)
                                
                                // LOGOUT BUTTON (No NavigationLink needed, just an action)
                                Button(action: { router.navigate(to: .signIn) }) {
                                    HStack {
                                        Spacer()
                                        Text("Log Out")
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                    .padding(.horizontal, 20)
                                }
                            }
                            
                            Spacer(minLength: 100)
                        }
                    }
                }
                
                CustomBottomNavBar(selectedTab: $currentTab)
            }
            .navigationTitle("Settings") // Native large title
        }
        .navigationBarHidden(true) 
        .onAppear {
            HatcheryDataService.shared.fetchMockUser(for: .supervisor) { user in
                self.currentUser = user
                self.isLoading = false
            }
        }
    }
}