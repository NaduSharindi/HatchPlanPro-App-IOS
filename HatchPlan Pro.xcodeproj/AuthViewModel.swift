import Foundation
import Combine
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var password: String = ""
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    init() {
        #if canImport(FirebaseAuth)
        isSignedIn = Auth.auth().currentUser != nil
        #else
        isSignedIn = false
        #endif
    }

    func signIn() async {
        #if canImport(FirebaseAuth)
        do {
            _ = try await Auth.auth().signIn(withEmail: userEmail, password: password)
            isSignedIn = true
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            isSignedIn = false
        }
        #else
        errorMessage = "FirebaseAuth not available. Add the FirebaseAuth package."
        #endif
    }

    func signUp() async {
        #if canImport(FirebaseAuth)
        do {
            _ = try await Auth.auth().createUser(withEmail: userEmail, password: password)
            isSignedIn = true
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            isSignedIn = false
        }
        #else
        errorMessage = "FirebaseAuth not available. Add the FirebaseAuth package."
        #endif
    }

    func signOut() {
        #if canImport(FirebaseAuth)
        do {
            try Auth.auth().signOut()
            isSignedIn = false
        } catch {
            errorMessage = error.localizedDescription
        }
        #else
        errorMessage = "FirebaseAuth not available. Add the FirebaseAuth package."
        #endif
    }
}
