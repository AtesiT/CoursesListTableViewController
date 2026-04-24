import Foundation

struct CourseDetailsDataStore {
    let courseName: String
    let numberOfLessons: Int
    let numberOfTests: Int
    //  Данные загружаются из сети и поэтому данные опциональны
    let imageData: Data?
    let isFavorite: Bool
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
    
    func favoriteButtonPressed() {
        interactor.toggleFavoriteStatus()
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
        view.displayImageForFavoriteButton(with: dataStore.isFavorite)
        
        guard let imageData = dataStore.imageData else { return }
        view.displayImageData(with: imageData)
    }
    
    func receiveFavoriteStatus(with status: Bool) {
        view.displayImageForFavoriteButton(with: status)
    }
}
