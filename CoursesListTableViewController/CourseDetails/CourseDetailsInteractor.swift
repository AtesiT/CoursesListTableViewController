protocol CourseDetailsBusinessLogic {
    func provideCourseDetails(request: CourseDetails.ShowDetails.Request)
}

protocol CourseDetailsDataStore {
    
}

class CourseDetailsInteractor: CourseDetailsBusinessLogic, CourseDetailsDataStore {
    
    var presenter: CourseDetailsPresentationLogic?
    var worker: CourseDetailsWorker?

    func provideCourseDetails(request: CourseDetails.ShowDetails.Request) {
        worker = CourseDetailsWorker()
        worker?.doSomeWork()

        let response = CourseDetails.ShowDetails.Response()
        presenter?.presentCourseDetails(response: response)
    }
}
