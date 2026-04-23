import Foundation

struct CourseDetailsDataStore {
    let courseName: String
    let numberOfLessons: Int
    let numberOfTests: Int
}

class CourseDetailsPresenter: CourseDetailsViewOutputProtocol {
    var interactor: CourseDetailsInteractorInputProtocol!
    private unowned let view: CourseDetailsViewInputProtocol
    
    required init(view: CourseDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideCourseDetails()
    }
}

//  MARK: - CourseDetailsInteractorOutputProtocol
extension CourseDetailsPresenter: CourseDetailsInteractorOutputProtocol {
    func recieveCourseDetails(with dataStore: CourseDetailsDataStore) {
        let numberOfLessons = "Number of lessons: \(dataStore.numberOfLessons)"
        let numberOfTests = "Number of tests: \(dataStore.numberOfTests)"
        
        view.displayCourseName(with: dataStore.courseName)
        view.displayNumberOfLessons(with: numberOfLessons)
        view.displayNumberOfTests(with: numberOfTests)
    }
}
