import Foundation

class HatcheryDataService {
    static let shared = HatcheryDataService()
    private init() {}
    
    // MARK: - Centralized Mock Data (From Figma)
    private let mockSensor = SensorData(temperature: 37.5, humidity: 58.0, co2Level: 0.4, timestamp: Date())
    
    private let mockBatches = [
        Batch(id: "#B1024", breed: "Ross 308", targetEggSet: 15000, currentDay: 18, totalDays: 21, approvalStatus: "Approved"),
        Batch(id: "#B1025", breed: "Cobb 500", targetEggSet: 12000, currentDay: 4, totalDays: 21, approvalStatus: "Pending")
    ]
    
    private let mockSupervisor = User(fullName: "Nimesha Fernando", firstName: "Nimesha", jobTitle: "Supervisor", employeeId: "HP-2024", facilityLocation: "Main Hatchery", role: .supervisor)

    // MARK: - Simulated Fetch Functions
    func fetchActiveBatches(completion: @escaping ([Batch]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { completion(self.mockBatches) }
    }
    
    func fetchLiveSensorData(completion: @escaping (SensorData) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { completion(self.mockSensor) }
    }
    
    func fetchMockUser(for role: UserRole, completion: @escaping (User) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { completion(self.mockSupervisor) }
    }
}