import SwiftUI

// MARK: - Reusable Custom TextField
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal, 24)
    }
}

// MARK: - 1. Sign In Screen
struct SignInView: View {
    @EnvironmentObject var router: AppRouter
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 60)
            
            Text("Sign in to continue managing your hatchery.")
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            
            CustomTextField(placeholder: "Email Address", text: $email)
            CustomTextField(placeholder: "Password", text: $password, isSecure: true)
            
            HStack {
                Spacer()
                Button("Forgot Password?") {
    router.navigate(to: .forgotPasswordRequest)
}
                .font(.caption)
                .foregroundColor(.blue)
                .padding(.trailing, 24)
            }
            
            Button(action: {
                // Simulate login, go straight to biometric prompt for testing
                router.navigate(to: .biometric)
            }) {
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
            }
            .padding(.top, 20)
            
            Spacer()
            
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.secondary)
                Button("Sign up") {
                    router.navigate(to: .signUp)
                }
                .fontWeight(.bold)
                .foregroundColor(.blue)
            }
            .padding(.bottom, 30)
        }
    }
}

// MARK: - 2. Sign Up Screen (Supervisor)
struct SignUpView: View {
    @EnvironmentObject var router: AppRouter
    @State private var email = ""
    @State private var password = ""
    @State private var facilityId = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { router.navigate(to: .signIn) }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            Text("Supervisor Access")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            
            CustomTextField(placeholder: "Email Address", text: $email)
            CustomTextField(placeholder: "Password", text: $password, isSecure: true)
            CustomTextField(placeholder: "Facility ID (e.g., HP-2024)", text: $facilityId)
            
            Spacer()
            
            Button(action: {
                router.tempSignUpEmail = email
                router.navigate(to: .completeProfile)
            }) {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
            }
            .padding(.bottom, 40)
        }
    }
}

// MARK: - 3. Complete Profile Screen
struct CompleteProfileView: View {
    @EnvironmentObject var router: AppRouter
    @State private var fullName = ""
    @State private var jobTitle = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Complete Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 60)
            
            Text("Tell us a bit about yourself.")
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            
            CustomTextField(placeholder: "Full Name", text: $fullName)
            CustomTextField(placeholder: "Job Title (e.g., Shift Supervisor)", text: $jobTitle)
            
            Spacer()
            
            Button(action: {
                // Here is where you would save to Firebase eventually.
                // For now, route to the biometric login.
                router.navigate(to: .biometric)
            }) {
                Text("Create Account")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
            }
            .padding(.bottom, 40)
        }
    }
}