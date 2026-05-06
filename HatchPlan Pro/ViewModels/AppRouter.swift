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
    case loggedIn
    // NEW STATES FOR FORGOT PASSWORD FLOW
    case forgotPasswordRequest
    case forgotPasswordOTP
    case forgotPasswordNew
    case forgotPasswordSuccess
}

class AppRouter: ObservableObject {
    @Published var currentState: AppState = .splash
    
    // Data passing variables
    @Published var tempSignUpEmail: String = ""
    @Published var tempResetEmail: String = "" // Stores email for the OTP screen
    
    func navigate(to state: AppState) {
        withAnimation {
            self.currentState = state
        }
    }
}