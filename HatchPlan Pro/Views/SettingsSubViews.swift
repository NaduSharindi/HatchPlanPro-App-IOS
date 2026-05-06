import SwiftUI

// MARK: - 1. Edit Profile Screen
struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var fullName = "Nimesha Fernando"
    @State private var email = "nimesha@primahatchery.com"
    @State private var phone = "+94 77 123 4567"
    
    var body: some View {
        VStack(spacing: 20) {
            // Profile Avatar Editor
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 100, height: 100)
                    .overlay(Text("N").font(.largeTitle).fontWeight(.bold).foregroundColor(.blue))
                
                Image(systemName: "camera.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
                    .background(Color.white.clipShape(Circle()))
                    .offset(x: -5, y: -5)
            }
            .padding(.top, 20)
            
            // Form Fields
            VStack(spacing: 16) {
                CustomTextField(placeholder: "Full Name", text: $fullName)
                CustomTextField(placeholder: "Email Address", text: $email)
                CustomTextField(placeholder: "Phone Number", text: $phone)
            }
            
            Spacer()
            
            Button(action: {
                // Save logic here (update mock data or Firebase)
                presentationMode.wrappedValue.dismiss() // Go back
            }) {
                Text("Save Changes")
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
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 2. Change Password Screen
struct ChangePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a new strong password that is at least 8 characters long.")
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .multilineTextAlignment(.leading)
            
            VStack(spacing: 16) {
                CustomTextField(placeholder: "Current Password", text: $currentPassword, isSecure: true)
                CustomTextField(placeholder: "New Password", text: $newPassword, isSecure: true)
                CustomTextField(placeholder: "Confirm New Password", text: $confirmPassword, isSecure: true)
            }
            
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Update Password")
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
        .navigationTitle("Change Password")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 3. Notification Settings Screen
struct NotificationPreferencesView: View {
    @State private var pushEnabled = true
    @State private var emailEnabled = false
    @State private var criticalAlerts = true
    @State private var batchUpdates = true
    
    var body: some View {
        Form {
            Section(header: Text("General Notifications")) {
                Toggle("Push Notifications", isOn: $pushEnabled)
                Toggle("Email Notifications", isOn: $emailEnabled)
            }
            
            Section(header: Text("Hatchery Alerts"), footer: Text("Critical alerts bypass silent mode to ensure immediate response to environmental failures.")) {
                Toggle("Critical Sensor Alerts", isOn: $criticalAlerts)
                    .tint(.red)
                Toggle("Batch Milestone Updates", isOn: $batchUpdates)
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}