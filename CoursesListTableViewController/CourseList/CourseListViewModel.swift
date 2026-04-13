import Foundation

protocol CourseListViewModelProtcol {
    #warning("TODO: private courses")
    var courses: [Product] { get }
    func fetchCourses(completion: @escaping() -> Void)
    func numberOfRows() -> Int
}

