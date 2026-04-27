protocol CourseListBusinessLogic {
    func fetchCourses()
}

protocol CourseListDataStore {
    
}

class CourseListInteractor: CourseListBusinessLogic, CourseListDataStore {
    
    var presenter: CourseListPresentationLogic?
    
    func fetchCourses() {
        let response = CourseList.ShowCourses.Response
        presenter?.presentCourses(response: response)
    }
}
