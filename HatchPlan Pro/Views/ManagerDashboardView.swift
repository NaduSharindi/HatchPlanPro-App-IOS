//
//  DashboardView.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

struct ManagerDashboardView: View {
    let user: User
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Pending Approvals")) {
                    ForEach(viewModel.activeBatches.filter { $0.approvalStatus == "Pending" }) { batch in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Batch \(batch.id)")
                                    .font(.headline)
                                Text(batch.breed)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button("Approve") {
                                // Logic for manager approval
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                Section(header: Text("Facility Insights")) {
                    HStack {
                        Label("Avg Temp", systemImage: "thermometer.medium")
                        Spacer()
                        Text("37.6°C").bold()
                    }
                    HStack {
                        Label("Efficiency", systemImage: "chart.bar.fill")
                        Spacer()
                        Text("94%").bold()
                    }
                }
            }
            .navigationTitle("Manager Portal")
        }
    }
}
