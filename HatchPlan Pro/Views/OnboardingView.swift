//
//  OnboardingView.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var router: AppRouter
    @State private var currentStep = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentStep) {
                // Onboarding Screen 1
                OnboardingStepView(
                    imageName: "chart.bar.xaxis", // Replace with your illustration
                    title: "Precision Hatchery\nManagement",
                    description: "Monitor environmental data, track batch progress, and streamline your hatchery operations all in one place.",
                    tag: 0
                )
                
                // Onboarding Screen 2
                OnboardingStepView(
                    imageName: "bell.badge.fill", // Replace with your illustration
                    title: "Real-Time Alerts &\nWorkflow Sync",
                    description: "Stay ahead with predictive insights, instant notifications, and seamless team collaboration.",
                    tag: 1
                )
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            // Next / Get Started Button
            Button(action: {
                if currentStep < 1 {
                    // Go to next page
                    withAnimation {
                        currentStep += 1
                    }
                } else {
                    // Finish onboarding, go to Authentication
                    router.navigate(to: .authentication)
                }
            }) {
                Text(currentStep == 0 ? "Next" : "Get Started")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

// Reusable component for the onboarding pages
struct OnboardingStepView: View {
    var imageName: String
    var title: String
    var description: String
    var tag: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Illustration placeholder
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .foregroundColor(.orange)
                .padding(.bottom, 40)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .tag(tag)
    }
}
