import Foundation

class HatcheryDataService {
    static let shared = HatcheryDataService()
    private init() {} 
    
    // MARK: - Centralized Mock Data matching Figma
    private let mockSensor = SensorData(temperature: 37.5, humidity: 58.2, timestamp: Date(), status: "Optimal Conditions")
    
    private let mockBatches = [
        Batch(id: "#B1024", breed: "Ross 308", targetEggSet: 15000, hatchDate: Date().addingTimeInterval(86400 * 9), approvalStatus: "Approved", progress: 12.0/21.0, currentDay: 12, totalDays: 21, nextPhase: "Transfer"),
        Batch(id: "#B1025", breed: "Cobb 500", targetEggSet: 12000, hatchDate: Date().addingTimeInterval(86400 * 17), approvalStatus: "Approved", progress: 4.0/21.0, currentDay: 4, totalDays: 21, nextPhase: "Candling")
    ]
    
    private let mockSupervisor = User(fullName: "Hasintha", jobTitle: "Supervisor", employeeId: "HP-2026", facilityLocation: "Main Hatchery", role: .supervisor)
    private let mockManager = User(fullName: "Sarah Manager", jobTitle: "Operations Manager", employeeId: "HP-2027", facilityLocation: "Main Hatchery", role: .manager)

    // MARK: - Fetch Functions
    func fetchActiveBatches(completion: @escaping ([Batch]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(self.mockBatches)
        }
    }
    
    func fetchLiveSensorData(completion: @escaping (SensorData) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(self.mockSensor)
        }
    }
    
    func fetchMockUser(for role: UserRole, completion: @escaping (User) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(role == .manager ? self.mockManager : self.mockSupervisor)
        }
    }
}