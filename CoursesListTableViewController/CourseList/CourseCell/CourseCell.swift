import UIKit

final class CourseCell: UITableViewCell {
    var viewModel: CourseCellViewModelProtcol!  {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.courseName
            guard let imageData = viewModel.imageData else { return }
            content.image = UIImage(data: imageData)
            contentConfiguration = content
        }
    }
}
