import UIKit

final class CourseDetailsViewController: UIViewController {

    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessonsLabel: UILabel!
    @IBOutlet var numberOfTestLabel: UILabel!
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var favoriteButton: UIButton!
    
//    var course: Course!
    var course: Product!
    var viewModel: CourseDetailsViewModelProtcol! {
        //  Как только есть изменения, то будет срабатывать данные метод
        didSet {
            viewModel.viewModelDidChange = { viewModel in
                self.setStatusForFavoriteButton(viewModel.isFavorite)
            }
            courseNameLabel.text = viewModel.courseName
            numberOfLessonsLabel.text = viewModel.numberOfLessons
            numberOfTestLabel.text = viewModel.numbersOfTests
            courseImage.image = UIImage(data: viewModel.imageData ?? Data())
        }
    }
    
    override func viewDidLoad() {
        viewModel = CourseDetailsViewModel(course: course)
        setupUI()
        super.viewDidLoad()
        
    }
    
    @IBAction func toggleFavorite() {
        viewModel.favoriteButtonPressed()
    }
    
    private func setupUI() {
        setStatusForFavoriteButton(viewModel.isFavorite)
    }
    
    private func setStatusForFavoriteButton(_ status: Bool) {
        favoriteButton.tintColor = status  ? .red : .gray
    }
}
