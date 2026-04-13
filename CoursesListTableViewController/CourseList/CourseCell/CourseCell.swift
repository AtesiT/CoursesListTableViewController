import UIKit

final class CourseCell: UITableViewCell {
    func configure(with course: Product) {
        var content = defaultContentConfiguration()
        content.text = course.name
        guard let imageData = ImageManager.shared.fetchImageData(from: course.imageURL) else { return }
        content.image = UIImage(data: imageData)
        contentConfiguration = content
    }
}
