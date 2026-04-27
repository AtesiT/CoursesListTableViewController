import Foundation

protocol CourseDetailsBusinessLogic {
    func provideCourseDetails(request: CourseDetails.ShowDetails.Request)
    func setFavoriteStatus()
}

protocol CourseDetailsDataStore {
    var course: Course? { get }
    var isFavorite: Bool { get }
}

class CourseDetailsInteractor: CourseDetailsBusinessLogic, CourseDetailsDataStore {
    var course: Course?
    var isFavorite: Bool = false
    var presenter: CourseDetailsPresentationLogic?
    var worker: CourseDetailsWorker?

    func provideCourseDetails(request: CourseDetails.ShowDetails.Request) {
        course = request.course
        worker = CourseDetailsWorker()
        isFavorite = worker?.getFavoriteStatus(for: course?.name ?? "") ?? False
        let imageData = worker?.getImage(from: course.imageURL)

        let response = CourseDetails.ShowDetails.Response(
            courseName: request.course?.name,
            numberOfLessons: course?.numberOfLessons,
            numberOfTests: course?.numberOfTests,
            imageData: imageData,
            isFavorite: isFavorite
        )
        presenter?.presentCourseDetails(response: response)
    }
    
    func setFavoriteStatus() {
        isFavorite.toggle()
        worker?.setNewFavoriteStatus(for: course?.name ?? "", with: isFavorite)
        
        let response = CourseDetails.SetFavoriteStatus.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteStatus(response: response)
    }
}
