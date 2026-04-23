import Foundation

struct CourseDetailsDataStore {
    let courseName: String
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
        view.displayCourseName(with: dataStore.courseName)
    }
}
