import SwiftUI

struct BatchHistoryView: View {
    @EnvironmentObject var router: AppRouter // For the back button
    @StateObject private var viewModel = DashboardViewModel()
    @State private var searchText = ""
    @State private var currentTab = 2 // Represents the Chart/History tab
    
    var filteredHistory: [Batch] {
        if searchText.isEmpty {
            return viewModel.historyBatches
        } else {
            return viewModel.historyBatches.filter { $0.id.localizedCaseInsensitiveContains(searchText) || $0.breed.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // 1. Header with Back Button
                HStack {
                    Button(action: {
                        // Navigate back logic
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Batch History")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    // Invisible placeholder to keep title centered
                    Image(systemName: "chevron.left").opacity(0)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // 2. Search and Filter Bar (Reused from previous view)
                SearchFilterBar(searchText: $searchText)
                
                // 3. Scrollable List of History
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading History...")
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(filteredHistory) { batch in
                                BatchHistoryRowView(batch: batch)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100) // Space for bottom nav
                    }
                }
            }
            
            // 4. Custom Bottom Navigation Bar
            CustomBottomNavBar(selectedTab: $currentTab)
        }
        .navigationBarHidden(true)
        .onAppear {
            // Ensure data is loaded
            viewModel.fetchData()
        }
    }
}