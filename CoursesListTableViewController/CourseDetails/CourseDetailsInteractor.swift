import Foundation

protocol CourseDetailsInteractorInputProtocol {
    init(presenter: CourseDetailsInteractorInputProtocol, course: Course)
    func provideCourseDetails()
}

protocol CourseDetailsInteractorOutputProtocol: AnyObject {
}

class CourseDetailsInteractor: CourseDetailsInteractorInputProtocol {
    private unowned let presenter: CourseDetailsInteractorOutputProtocol
    private let course: Course
    
    required init(presenter: CourseDetailsInteractorOutputProtocol, course: Course) {
        self.presenter = presenter
        self.course = course
    }
    
    func provideCourseDetails() {
        
    }
}
