import Foundation
#if canImport(FirebaseCore)
import FirebaseCore
#endif
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif
#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif
#if canImport(FirebaseStorage)
import FirebaseStorage
#endif

final class FirebaseManager {
    static let shared = FirebaseManager()

    #if canImport(FirebaseAuth)
    let auth: Auth = Auth.auth()
    #else
    let auth: Any? = nil
    #endif

    #if canImport(FirebaseFirestore)
    let db: Firestore = Firestore.firestore()
    #else
    let db: Any? = nil
    #endif

    #if canImport(FirebaseStorage)
    let storage: Storage = Storage.storage()
    #else
    let storage: Any? = nil
    #endif

    private init() {}
}
