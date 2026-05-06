//
//  ContentView.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-04.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = AppRouter()
    
    var body: some View {
        Group {
            switch router.currentState {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView()
            case .signIn:
                SignInView()
            case .signUp:
                SignUpView()
            case .completeProfile:
                CompleteProfileView()
                case .biometricSetup:
                BiometricSetupView()
            case .loggedIn:
                SupervisorDashboardView() 
            case .forgotPasswordRequest:
                ForgotPasswordRequestView()
            case .forgotPasswordOTP:
                ForgotPasswordOTPView()
            case .forgotPasswordNew:
                ForgotPasswordNewView()
            case .forgotPasswordSuccess:
                PasswordResetSuccessView()
            }
        }
        .environmentObject(router)
    }
}