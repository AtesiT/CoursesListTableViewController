protocol CourseListBusinessLogic {
    func fetchCourses()
}

protocol CourseListDataStore {
    var courses: [Course] { get }
}

class CourseListInteractor: CourseListBusinessLogic, CourseListDataStore {
    
    var presenter: CourseListPresentationLogic?
    var courses: [Course] = []
    
    func fetchCourses() {
        NetworkManager.shared.fetchData { [weak self] courses in
            self?.courses = courses
            let response = CourseList.ShowCourses.Response(courses: courses)
            self?.presenter?.presentCourses(response: response)
        }
    }
}
