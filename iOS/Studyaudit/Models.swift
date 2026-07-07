import Foundation

struct LogItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String          // Subject
    var amount: Double         // Actual hours
    var date: Date             // Week of
    var isComplete: Bool       // Reviewed
    var notes: String = ""
    var createdAt: Date = Date()
}
