//
//  SplashView.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: AppRouter
    @State private var showLoading = false
    
    var body: some View {
        ZStack {
            // Dark background from Figma
            Color(red: 0.1, green: 0.1, blue: 0.12).ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Logo placeholder
                Image(systemName: "egg.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(red: 0.95, green: 0.42, blue: 0.31)) // Figma Orange
                
                Text("HatchPlan Pro")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 16)
                
                Spacer()
                
                if showLoading {
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Text("Loading parameters...")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation { showLoading = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                router.navigate(to: .onboarding)
            }
        }
    }
}