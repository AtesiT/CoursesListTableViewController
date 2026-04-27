protocol CourseListPresentationLogic {
    func presentCourses(response: CourseList.ShowCourses.Response)
}

class CourseListPresenter: CourseListPresentationLogic {

    weak var viewController: CourseListDisplayLogic?

    func presentCourses(response: CourseList.ShowCourses.Response) {
        let viewModel = CourseList.ShowCourses.ViewModel()
        viewController?.displayCourses(viewModel: viewModel)
    }
}
