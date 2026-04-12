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
            courseNameLabel.text = viewModel.courseName
            numberOfLessonsLabel.text = viewModel.numberOfLessons
            numberOfTestLabel.text = viewModel.numbersOfTests
        }
    }
    
    private var isFavorite = false
    
    override func viewDidLoad() {
        loadFavoriteStatus()
        viewModel = CourseDetailsViewModel(course: course)
        setupUI()
        super.viewDidLoad()
        
    }
    
    @IBAction func toggleFavorite() {
        isFavorite.toggle()
        setStatusForFavoriteButton()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite)
    }
    
    private func setupUI() {
        
        if let imageData = ImageManager.shared.fetchImageData(from: course.imageURL) {
            courseImage.image = UIImage(data: imageData)
        }
        
        setStatusForFavoriteButton()
    }
    
    private func setStatusForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .red : .gray
    }
    
    private func loadFavoriteStatus() {
        isFavorite = DataManager.shared.getFavoriteStatus(for: course.name)
    }
}
