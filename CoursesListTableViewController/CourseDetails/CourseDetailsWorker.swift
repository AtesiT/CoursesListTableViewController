import Foundation

class CourseDetailsWorker {
    func getImage(from ImageURL: URL?) -> Data? {
        ImageManager.shared.fetchImageData(from: ImageURL)
    }
    
    func getFavoriteStatus(for courseName: String ) -> Bool {
        DataManager.shared.getFavoriteStatus(for: courseName)
    }
}
