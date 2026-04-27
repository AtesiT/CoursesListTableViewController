protocol CourseDetailsPresentationLogic {
    func presentCourseDetails(response: CourseDetails.ShowDetails.Response)
}

class CourseDetailsPresenter: CourseDetailsPresentationLogic {
    weak var viewController: CourseDetailsDisplayLogic?

    func presentCourseDetails(response: CourseDetails.ShowDetails.Response) {
        let numberOfLessonsLabel = "Number of lessons: \(response.numberOfLessons ?? 0)"
        let numberOfTestsLabel = "Number of tests: \(response.numberOfTests ?? 0)"

        let viewModel = CourseDetails.ShowDetails.ViewModel(
            courseName: response.courseName ?? "",
            numberOfLessons: numberOfLessons,
            NumberOfTests: numberOfTests
        )
        viewController?.displayCourseDetails(viewModel: viewModel)
    }
}
