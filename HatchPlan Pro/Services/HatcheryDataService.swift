import Foundation

class HatcheryDataService {
    static let shared = HatcheryDataService()
    private init() {}
    
    // MARK: - Centralized Mock Data
    private let mockSensor = SensorData(temperature: 37.5, humidity: 58.0, co2Level: 0.4, timestamp: Date())
    
    // Expanded mock batches to fill out the list view
    private let mockBatches = [
        Batch(id: "#B1024", breed: "Ross 308", targetEggSet: 15000, currentDay: 18, totalDays: 21, approvalStatus: "Approved"),
        Batch(id: "#B1025", breed: "Cobb 500", targetEggSet: 12000, currentDay: 4, totalDays: 21, approvalStatus: "Pending"),
        Batch(id: "#B1026", breed: "Lohmann Brown", targetEggSet: 10000, currentDay: 10, totalDays: 21, approvalStatus: "Approved"),
        Batch(id: "#B1027", breed: "Ross 308", targetEggSet: 14500, currentDay: 1, totalDays: 21, approvalStatus: "Pending")
    ]
    
    private let mockSupervisor = User(fullName: "Nimesha Fernando", firstName: "Nimesha", jobTitle: "Supervisor", employeeId: "HP-2024", facilityLocation: "Main Hatchery", role: .supervisor)

    private let mockHistoryBatches = [
        Batch(id: "#B1020", breed: "Cobb 500", targetEggSet: 14500, currentDay: 21, totalDays: 21, approvalStatus: "Hatched", rating: 4.8, completionDate: "Oct 12, 2023"),
        Batch(id: "#B1019", breed: "Ross 308", targetEggSet: 15200, currentDay: 21, totalDays: 21, approvalStatus: "Failed", rating: 2.1, completionDate: "Sep 28, 2023"),
        Batch(id: "#B1018", breed: "Lohmann Brown", targetEggSet: 10000, currentDay: 21, totalDays: 21, approvalStatus: "Hatched", rating: 4.5, completionDate: "Sep 15, 2023")
    ]

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

    func fetchHistoryBatches(completion: @escaping ([Batch]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { completion(self.mockHistoryBatches) }
    }
}