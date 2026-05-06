import Foundation

// When you are ready for Firebase, you will replace the code inside these functions
// with your Firebase Firestore queries!
class HatcheryDataService {
    
    // Singleton pattern allows easy access to this service anywhere in the app
    static let shared = HatcheryDataService()
    
    private init() {} // Prevents creating multiple instances
    
    // MARK: - Centralized Mock Data
    private let mockSensor = SensorData(temperature: 37.5, humidity: 58.0, timestamp: Date())
    
    private let mockBatches = [
        Batch(id: "#B1024", breed: "Ross 308", targetEggSet: 15000, hatchDate: Date().addingTimeInterval(86400 * 4), approvalStatus: "Approved", progress: 0.92),
        Batch(id: "#B1025", breed: "Cobb 500", targetEggSet: 12000, hatchDate: Date().addingTimeInterval(86400 * 10), approvalStatus: "Pending", progress: 0.45)
    ]
    
    private let mockManager = User(fullName: "Sarah Manager", jobTitle: "Operations Manager", employeeId: "HP-2026", facilityLocation: "Main Hatchery", role: .manager)
    private let mockSupervisor = User(fullName: "John Supervisor", jobTitle: "Lead Supervisor", employeeId: "HP-2026", facilityLocation: "Main Hatchery", role: .supervisor)

    // MARK: - Simulated Fetch Functions
    
    func fetchActiveBatches(completion: @escaping ([Batch]) -> Void) {
        // Simulating a 1.5 second network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion(self.mockBatches)
        }
    }
    
    func fetchLiveSensorData(completion: @escaping (SensorData) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion(self.mockSensor)
        }
    }
    
    func fetchMockUser(for role: UserRole, completion: @escaping (User) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let user = role == .manager ? self.mockManager : self.mockSupervisor
            completion(user)
        }
    }
}