//
//  ContentView.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-04.
//

import SwiftUI

struct ContentView: View {
    // Create the router here and inject it into the app
    @StateObject private var router = AppRouter()
    
    var body: some View {
        Group {
            switch router.currentState {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView()
            case .authentication:
                LoginView() // The Biometric login view we made earlier
            case .loggedIn:
                // We handle role-based routing inside LoginView right now,
                // but you can expand this later.
                Text("Dashboard Loading...")
            }
        }
        // This makes the router available to all sub-views
        .environmentObject(router)
    }
}
