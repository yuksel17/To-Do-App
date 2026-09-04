import Foundation

struct TodoItem: Codable {
    var id: UUID
    var title: String
    var note: String
    var dueDate: Date? // İsteğe bağlı teslim tarihi
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, note: String = "", dueDate: Date? = nil, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.note = note
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
