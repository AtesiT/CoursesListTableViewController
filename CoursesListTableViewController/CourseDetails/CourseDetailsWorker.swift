import Foundation

class CourseDetailsWorker {
    func getImage(from ImageURL: URL?) -> Data? {
        ImageManager.shared.fetchImageData(from: ImageURL)
    }
}
