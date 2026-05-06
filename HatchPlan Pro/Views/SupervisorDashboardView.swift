//
//  SupervisorDashboardView.swift.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

struct SupervisorDashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground).ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView("Updating Sensors...")
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            SensorCardView(sensor: viewModel.currentSensor)
                            
                            VStack(alignment: .leading) {
                                Text("Active Batches")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ForEach(viewModel.activeBatches) { batch in
                                    BatchRowView(batch: batch)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Supervisor Portal")
        }
    }
}
