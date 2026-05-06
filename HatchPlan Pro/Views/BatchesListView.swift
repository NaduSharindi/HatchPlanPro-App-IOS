import SwiftUI

struct BatchesListView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var searchText = ""
    @State private var currentTab = 1 // 1 represents the Batches/Calendar tab
    
    // Using our mock supervisor directly for the UI build
    private let mockUser = User(fullName: "Nimesha Fernando", firstName: "Nimesha", jobTitle: "Supervisor", employeeId: "HP-2024", facilityLocation: "Main", role: .supervisor)
    
    var filteredBatches: [Batch] {
        if searchText.isEmpty {
            return viewModel.activeBatches
        } else {
            return viewModel.activeBatches.filter { $0.id.localizedCaseInsensitiveContains(searchText) || $0.breed.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Light gray background from Figma
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 20) {
                // 1. Header (Reused from Dashboard)
                DashboardHeaderView(user: mockUser)
                
                // 2. Title Row with Add Button
                HStack {
                    Text("Active Batches")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        // Action to log new batch
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding(10)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                
                // 3. Search and Filter Bar
                SearchFilterBar(searchText: $searchText)
                
                // 4. Scrollable List of Batches
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading Batches...")
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(filteredBatches) { batch in
                                BatchListRowView(batch: batch)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100) // Give space for the bottom nav bar
                    }
                }
            }
            .padding(.top, 10)
            
            // 5. Bottom Navigation Bar (Tab 1 selected)
            CustomBottomNavBar(selectedTab: $currentTab)
        }
        .navigationBarHidden(true)
    }
}