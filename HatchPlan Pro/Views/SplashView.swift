//
//  SplashView.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: AppRouter
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Main Background Color
            Color.white.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Placeholder for your actual Logo image
                // Replace "egg.fill" with your asset name later: Image("YourLogoName")
                Image(systemName: "egg.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.orange)
                    .scaleEffect(isAnimating ? 1.0 : 0.8)
                    .opacity(isAnimating ? 1.0 : 0.0)
                
                Text("HatchPlan Pro")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .opacity(isAnimating ? 1.0 : 0.0)
                
                Spacer()
                
                // Loading Indicator at the bottom
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    .scaleEffect(1.5)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            // Animate the logo popping in
            withAnimation(.easeOut(duration: 1.0)) {
                isAnimating = true
            }
            
            // Wait 2.5 seconds, then tell the router to go to Onboarding
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                router.navigate(to: .onboarding)
            }
        }
    }
}
