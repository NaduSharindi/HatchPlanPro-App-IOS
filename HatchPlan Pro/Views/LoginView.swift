//
//  LoginView.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI
import Combine

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        if viewModel.isAuthenticated, let user = viewModel.currentUser {
            // Role-based routing
            if user.role == .manager {
                ManagerDashboardView(user: user)
            } else {
                SupervisorDashboardView()
            }
        } else {
            VStack(spacing: 40) {
                Spacer()
                Image(systemName: "egg.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.orange)
                
                Text("HatchPlan Pro")
                    .font(.largeTitle).bold()
                
                VStack(spacing: 15) {
                    Button("Login as Supervisor") {
                        viewModel.authenticate(as: .supervisor)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    
                    Button("Login as Manager") {
                        viewModel.authenticate(as: .manager)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
                
                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red).font(.caption)
                }
                Spacer()
            }
        }
    }
}
