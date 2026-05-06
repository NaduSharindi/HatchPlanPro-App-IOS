//
//  AppRouter.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import Foundation
import SwiftUI
import Combine

enum AppState {
    case splash
    case onboarding
    case signIn
    case signUp
    case completeProfile
    case biometricSetup
    case biometric
    case loggedIn
}

class AppRouter: ObservableObject {
    @Published var currentState: AppState = .splash
    
    // Pass data between screens (like the user's email during signup)
    @Published var tempSignUpEmail: String = ""
    
    func navigate(to state: AppState) {
        withAnimation {
            self.currentState = state
        }
    }
}