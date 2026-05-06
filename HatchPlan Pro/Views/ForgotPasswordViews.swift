import SwiftUI

// MARK: - 1. Request OTP Screen
struct ForgotPasswordRequestView: View {
    @EnvironmentObject var router: AppRouter
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Back Button
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
            
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            Text("Enter your email address to receive a verification code.")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            
            CustomTextField(placeholder: "Email Address", text: $email)
            
            Spacer()
            
            Button(action: {
                // Save the email to the router so the next screen can display it
                router.tempResetEmail = email
                router.navigate(to: .forgotPasswordOTP)
            }) {
                Text("Send OTP")
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

// MARK: - 2. Enter OTP Screen
struct ForgotPasswordOTPView: View {
    @EnvironmentObject var router: AppRouter
    // Simulated OTP digits
    @State private var pin1 = ""
    @State private var pin2 = ""
    @State private var pin3 = ""
    @State private var pin4 = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { router.navigate(to: .forgotPasswordRequest) }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            Text("We've sent a 4-digit code to \(router.tempResetEmail.isEmpty ? "your email" : router.tempResetEmail).")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            
            // OTP UI
            HStack(spacing: 15) {
                OTPTextField(text: $pin1)
                OTPTextField(text: $pin2)
                OTPTextField(text: $pin3)
                OTPTextField(text: $pin4)
            }
            .padding(.horizontal, 24)
            
            HStack {
                Text("Didn't receive the code?")
                    .foregroundColor(.secondary)
                Button("Resend Code") {
                    // Logic to resend
                }
                .fontWeight(.bold)
                .foregroundColor(.blue)
            }
            .font(.footnote)
            .padding(.top, 10)
            
            Spacer()
            
            Button(action: {
                router.navigate(to: .forgotPasswordNew)
            }) {
                Text("Verify OTP")
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

// MARK: - 3. New Password Screen
struct ForgotPasswordNewView: View {
    @EnvironmentObject var router: AppRouter
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { router.navigate(to: .forgotPasswordOTP) }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            Text("New Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            Text("Create a new strong password for your account.")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            
            CustomTextField(placeholder: "New Password", text: $newPassword, isSecure: true)
            CustomTextField(placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)
            
            Spacer()
            
            Button(action: {
                // Here you would eventually update Firebase with the new password
                router.navigate(to: .forgotPasswordSuccess)
            }) {
                Text("Reset Password")
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

// MARK: - 4. Success Screen
struct PasswordResetSuccessView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
                .padding(.bottom, 20)
            
            Text("Password Reset Successful")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Text("You can now log in with your new password.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button(action: {
                // Take them back to the sign in screen to log in
                router.navigate(to: .signIn)
            }) {
                Text("Back to Login")
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
}

// MARK: - Helper UI Component for OTP
struct OTPTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.title)
            .frame(width: 60, height: 60)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
    }
}