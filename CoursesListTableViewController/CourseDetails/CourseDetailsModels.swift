enum CourseDetailsModels {
    
    //  MARK: Use Cases
    enum ShowDetails {
        struct Request {
            let course: Course
        }
        
        struct Response {
            let courseName: String?
        }
        
        struct ViewModel {
            let courseName: String
        }
    }
}
