import Foundation

protocol CourseCellViewModelProtcol {
    var courseName: String { get }
    var imageData: Data? { get }
    init(course: Product)
}

class CourseCellViewModel: CourseCellViewModelProtcol {
    
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
