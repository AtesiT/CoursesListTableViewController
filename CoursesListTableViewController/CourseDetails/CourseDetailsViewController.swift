import UIKit

protocol CourseDetailsViewInputProtocol: AnyObject {
    
}

protocol CourseDetailsViewOutputProtocol {
    init(view: CourseDetailsViewInputProtocol)
    func showDetails()
}

final class CourseDetailsViewController: UIViewController {
    
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessonsLabel: UILabel!
    @IBOutlet var numberOfTestLabel: UILabel!
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var favoriteButton: UIButton!
    
    var course: Course!
    var presenter: CourseDetailsViewOutputProtocol!
    var configurator: CourseDetailsConfiguratorInputProtocol = CourseDetailsConfigurator!
    
    private var isFavorite = false
    
    var viewModel: CourseDetailsViewModelProtcol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(withView: self, and: course)
        loadFavoriteStatus()
        setupUI()
        presenter.showDetails()
    }
    
    @IBAction func toggleFavorite() {
        isFavorite.toggle()
        setStatusForFavoriteButton()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite)
    }
    
    private func setupUI() {
        courseNameLabel.text = course.name
        numberOfLessonsLabel.text = "Number of lessons: \(course.numberOfLessons)"
        numberOfTestLabel.text = "Number of tests: \(course.numberOfTests)"
        
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

//  MARK: - CourseDetailsViewInputProtocol
extension CourseDetailsViewController: CourseDetailsViewInputProtocol {
    
}
