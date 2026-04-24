import Foundation

protocol CourseDetailsInteractorInputProtocol {
    var isFavorite: Bool { get }
    init(presenter: CourseDetailsInteractorInputProtocol, course: Course)
    func provideCourseDetails()
}

protocol CourseDetailsInteractorOutputProtocol: AnyObject {
    func recieveCourseDetails(with dataStore: CourseDetailsDataStore)
}

class CourseDetailsInteractor: CourseDetailsInteractorInputProtocol {
    var isFavorite: Bool {
        DataManager.shared.getFavoriteStatus(for: course.name)
    }
    
    private unowned let presenter: CourseDetailsInteractorOutputProtocol
    private let course: Course
    
    required init(presenter: CourseDetailsInteractorOutputProtocol, course: Course) {
        self.presenter = presenter
        self.course = course
    }
    
    func provideCourseDetails() {
        let imageData = ImageManager.shared.fetchImageData(from: course.imageURL)
        
        let dataStore = CourseDetailsDataStore(
            courseName: course.name,
            numberOfLessons: course.numberOfLessons,
            numberOfTests: course.numberOfTests,
            imageData: imageData,
            isFavorite: isFavorite
        )
        presenter.recieveCourseDetails(with: dataStore)
    }
}
