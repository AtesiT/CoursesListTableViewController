import Foundation

enum CourseDetailsModels {
    
    //  MARK: Use Cases
    enum ShowDetails {
        struct Request {
            let course: Course
        }
        
        struct Response {
            let courseName: String?
            let numberOfLessons: Int?
            let numberOfTests: Int?
            let imageData: Data?
            let isFavorite: Bool
        }
        
        struct ViewModel {
            let courseName: String
            let numberOfLessons: String
            let numberOfTests: String
            let imageData: Data
            let isFavorite: Bool
        }
    }
    
    enum SetFavoriteStatus {
        struct Response {
            let isFavorite: Bool
        }
        
        struct ViewModel {
            let isFavorite: Bool
        }
    }
}
