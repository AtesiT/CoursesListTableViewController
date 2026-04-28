import Foundation

typealias CourseCellViewModel = CourseList.ShowCourse.ViewModel.CourseCellViewModel 

protocol CourseCellViewModelProtcol {
    var identifier: String { get }
    var height: Double { get }
    var courseName: String { get }
    var imageData: Data? { get }
    init(course: Course)
}

enum CourseList {
    
    //  MARK: Use Cases
    enum ShowCourses {
        
        struct Response {
            let courses: [Course]
        }
        
        struct ViewModel {
            struct CourseCellViewModel: CourseCellViewModelProtcol {
                var identifier: String {
                    "CourseCell"
                }
                
                var height: Double {
                    100
                }
                
                var courseName: String {
                    course.name
                }
                
                var imageData: Data? {
                    ImageManager.shared.fetchImageData(from: course.imageURL)
                }
                
                private let course: Course
                
                init(course: Course) {
                    self.course = course
                }
            }
            
            let rows: [CourseCellViewModelProtcol]
        }
    }
}
