import UIKit

protocol CellModelRepresentable {
    var viewModel: CourseCellViewModelProtcol? { get }
}

class CourseCell: UITableViewCell, CellModelRepresentable {
    var viewModel: CourseCellViewModelProtcol? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel as? CourseCellViewModel else { return }
        var content = defaultContentConfiquration()
        content.text = viewModel.courseName
        if let imageData = viewModel.imageData {
            content.image = UIImage(data: imageData)
        }
        contentConfiguration = content
    }
}
