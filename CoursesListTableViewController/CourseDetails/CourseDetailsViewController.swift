import UIKit

final class CourseDetailsViewController: UIViewController {

    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessonsLabel: UILabel!
    @IBOutlet var numberOfTestLabel: UILabel!
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var favoriteButton: UIButton!
 
    var viewModel: CourseDetailsViewModelProtcol!
    
    override func viewDidLoad() {
        setupUI()
        super.viewDidLoad()
        
    }
    
    @IBAction func toggleFavorite() {
        viewModel.favoriteButtonPressed()
    }
    
    private func setupUI() {
        setStatusForFavoriteButton(viewModel.isFavorite)
        
        viewModel.viewModelDidChange = { [unowned self] viewModel in
            setStatusForFavoriteButton(viewModel.isFavorite)
        }
        courseNameLabel.text = viewModel.courseName
        numberOfLessonsLabel.text = viewModel.numberOfLessons
        numberOfTestLabel.text = viewModel.numbersOfTests
        courseImage.image = UIImage(data: viewModel.imageData ?? Data())

    }
    
    private func setStatusForFavoriteButton(_ status: Bool) {
        favoriteButton.tintColor = status  ? .red : .gray
    }
    
    deinit {
        print("View Controller has been deallocated")
    }
}
