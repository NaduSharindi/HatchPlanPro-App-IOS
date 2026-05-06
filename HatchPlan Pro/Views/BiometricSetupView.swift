import SwiftUI
import LocalAuthentication

// Define the steps in the setup process
enum BiometricSetupStep {
    case start
    case scanning
    case success
}

// Define the type of biometrics the device supports
enum BiometricType {
    case faceID
    case touchID
    case none
}

struct BiometricSetupView: View {
    @EnvironmentObject var router: AppRouter
    @State private var currentStep: BiometricSetupStep = .start
    @State private var biometricType: BiometricType = .faceID
    
    var body: some View {
        ZStack {
            // Dark background matching your Figma
            Color(red: 0.1, green: 0.1, blue: 0.12).ignoresSafeArea()
            
            switch currentStep {
            case .start:
                setupStartView
            case .scanning:
                setupScanningView
            case .success:
                setupSuccessView
            }
        }
        .onAppear {
            checkDeviceBiometrics()
        }
    }
    
    // MARK: - 1. Start Screen
    private var setupStartView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Icon based on device capabilities
            Image(systemName: biometricType == .touchID ? "touchid" : "faceid")
                .font(.system(size: 80))
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            Text(biometricType == .touchID ? "Set up Touch ID" : "Set up Face ID")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Enable secure, instant access to your hatchery analytics and biological windows.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            // Get Started Button
            Button(action: {
                withAnimation { currentStep = .scanning }
                simulateScanningProcess()
            }) {
                Text("Get Started")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            
            // Skip Button
            Button(action: {
                router.navigate(to: .loggedIn) // Skip straight to dashboard
            }) {
                Text("Skip for now")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 40)
        }
    }
    
    // MARK: - 2. Scanning Screen (Simulated UI)
    private var setupScanningView: some View {
        VStack {
            Spacer()
            
            ZStack {
                // Background scanning grid/circle placeholder
                Circle()
                    .stroke(Color.blue.opacity(0.3), lineWidth: 2)
                    .frame(width: 250, height: 250)
                
                Image(systemName: biometricType == .touchID ? "touchid" : "faceid")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    // Add a pulsing animation to simulate scanning
                    .modifier(PulseEffect()) 
            }
            .padding(.bottom, 40)
            
            Text(biometricType == .touchID ? "Place your finger on the sensor" : "Position your face within the frame")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: {
                withAnimation { currentStep = .start }
            }) {
                Text("Cancel")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 40)
        }
    }
    
    // MARK: - 3. Success Screen
    private var setupSuccessView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
                .padding(.bottom, 20)
            
            Text(biometricType == .touchID ? "Touch ID Set Up successfully" : "Face ID Set Up successfully")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button(action: {
                // Setup complete, move to the dashboard!
                router.navigate(to: .loggedIn)
            }) {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }
    
    // MARK: - Helper Methods
    private func checkDeviceBiometrics() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if context.biometryType == .touchID {
                self.biometricType = .touchID
            } else {
                self.biometricType = .faceID
            }
        }
    }
    
    private func simulateScanningProcess() {
        // Here we simulate the time it takes to scan before showing the success screen.
        // In a real production app, this is where you would call context.evaluatePolicy()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.currentStep = .success
            }
        }
    }
}

// Custom animation modifier to make the icon "pulse" during scanning
struct PulseEffect: ViewModifier {
    @State private var isPulsing = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.1 : 0.9)
            .opacity(isPulsing ? 1.0 : 0.5)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                    isPulsing = true
                }
            }
    }
}