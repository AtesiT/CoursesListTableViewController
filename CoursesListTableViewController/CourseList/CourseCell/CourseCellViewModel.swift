import Foundation

protocol CourseCellViewModelProtcol {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
    var courseName: String { get }
    var imageData: Data? { get }
    init(course: Product)
}

protocol CourseSectionViewModelProtcol {
    var rows: [CourseCellViewModelProtcol] { get }
    var numberOfRows: Int { get }
}

class CourseCellViewModel: CourseCellViewModelProtcol {
    var cellIdentifier: String {
        "CourseCell"
    }
    
    var cellHeight: Double {
        100
    }
    
    
    var courseName: String {
        course.name
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: course.imageURL)
    }
    
    private let course: Product
    
    required init(course: Product) {
        self.course = course
    }
}

class CourseSectionViewModel: CourseSectionViewModelProtcol {
    var rows: [CourseCellViewModelProtcol]
    var numberOfRows: Int {
        rows.count
    }
}

