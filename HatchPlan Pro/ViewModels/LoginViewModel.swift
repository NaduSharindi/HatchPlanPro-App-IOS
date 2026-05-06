//
//  LoginViewModel.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import Foundation
import LocalAuthentication
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var currentUser: User?
    
    func authenticate(as role: UserRole) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Access HatchPlan Pro secure data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.loadUserFromService(role: role)
                    } else {
                        self.errorMessage = "Authentication failed."
                    }
                }
            }
        } else {
            // Simulator fallback
            DispatchQueue.main.async {
                self.loadUserFromService(role: role)
            }
        }
    }
    
    private func loadUserFromService(role: UserRole) {
        // Fetch the user from our new central service
        HatcheryDataService.shared.fetchMockUser(for: role) { [weak self] fetchedUser in
            self?.currentUser = fetchedUser
            self?.isAuthenticated = true
        }
    }
}