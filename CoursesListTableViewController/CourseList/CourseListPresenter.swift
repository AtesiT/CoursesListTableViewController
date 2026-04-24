import Foundation

struct CourseListDataStore {
    let courses: [Course]
}


class CourseListPresenter: CourseListViewOutputProtocol {
    var interactor: CourseListInteractorInputProtocol!
    var router: CourseListRouterInputProtocol!
    
    private unowned let view: CourseListViewInputProtcol!
    private var dataStore: CourseListDataStore?
    
    required init(view: CourseListViewInputProtcol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchCourses()
    }
}

//  MARK: - CourseListInteractorOutputProtocol
extension CourseListPresenter: CourseListInteractorOutputProtocol {
    func coursesDidReceive(with dataStore: CourseListDataStore) {
        self.dataStore = dataStore
        view.display(courses: dataStore.courses)
    }
}
