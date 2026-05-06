//
//  AppRouter.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import Foundation
import SwiftUI
import Combine

// This enum defines the different stages of your app's flow
enum AppState {
    case splash
    case onboarding
    case authentication
    case loggedIn
}

class AppRouter: ObservableObject {
    @Published var currentState: AppState = .splash
    
    // Function to move to the next screen
    func navigate(to state: AppState) {
        withAnimation {
            self.currentState = state
        }
    }
}
