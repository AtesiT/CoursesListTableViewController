protocol CourseDetailsBusinessLogic {
    func provideCourseDetails(request: CourseDetails.ShowDetails.Request)
}

protocol CourseDetailsDataStore {
    var course: Course? { get }
}

class CourseDetailsInteractor: CourseDetailsBusinessLogic, CourseDetailsDataStore {
    
    var presenter: CourseDetailsPresentationLogic?
    var worker: CourseDetailsWorker?

    func provideCourseDetails(request: CourseDetails.ShowDetails.Request) {
        course = request.course
        worker = CourseDetailsWorker()
        worker?.doSomeWork()

        let response = CourseDetails.ShowDetails.Response(courseName: request.course?.name)
        presenter?.presentCourseDetails(response: response)
    }
}
