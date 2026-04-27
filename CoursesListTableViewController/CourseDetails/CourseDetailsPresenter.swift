protocol CourseDetailsPresentationLogic {
    func presentCourseDetails(response: CourseDetails.ShowDetails.Response)
}

class CourseDetailsPresenter: CourseDetailsPresentationLogic {
    weak var viewController: CourseDetailsDisplayLogic?

    func presentCourseDetails(response: CourseDetails.ShowDetails.Response) {
        let viewModel = CourseDetails.ShowDetails.ViewModel(courseName: response.courseName ?? "")
        viewController?.displayCourseDetails(viewModel: viewModel)
    }
}
