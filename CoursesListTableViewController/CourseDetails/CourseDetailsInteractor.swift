import Foundation

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
        let imageData = worker?.getImage(from: course.imageURL)

        let response = CourseDetails.ShowDetails.Response(
            courseName: request.course?.name,
            numberOfLessons: course?.numberOfLessons,
            numberOfTests: course?.numberOfTests,
            imageData: imageData
        )
        presenter?.presentCourseDetails(response: response)
    }
}
