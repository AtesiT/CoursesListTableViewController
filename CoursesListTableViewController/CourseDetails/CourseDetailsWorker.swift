import Foundation

class CourseDetailsWorker {
    func getImage(from ImageURL: URL?) -> Data? {
        ImageManager.shared.fetchImageData(from: ImageURL)
    }
    
    func getFavoriteStatus(for courseName: String ) -> Bool {
        DataManager.shared.getFavoriteStatus(for: courseName)
    }
    
    func setNewFavoriteStatus(for courseName: String, with status: Bool) {
        DataManager.shared.setFavoriteStatus(for: courseName, with: status)
    }
}
