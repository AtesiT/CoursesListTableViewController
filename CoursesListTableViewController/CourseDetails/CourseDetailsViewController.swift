import UIKit
protocol CourseDetailsDisplayLogic: AnyObject {
    func displayCourseDetails(viewModel: CourseDetails.ShowDetails.ViewModel)
}

class CourseDetailsViewController: UIViewController, CourseDetailsDisplayLogic {
    @IBOutlet private var courseImageView: UIImageView!
    @IBOutlet private var courseNameLabel: UILabel!
    @IBOutlet private var numberOfLessonsLabel: UILabel!
    @IBOutlet private var numberOfTestsLabel: UILabel!
    @IBOutlet private var favoriteButton: UIButton!
    
    var course: Course!
    var interactor: CourseDetailsBusinessLogic?
    var router: (NSObjectProtocol & CourseDetailsRoutingLogic & CourseDetailsDataPassing)?
    private var isFavorite = false
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        CourseDetailsConfigurator.shared.configure(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CourseDetailsConfigurator.shared.configure(with: self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavoriteStatus()
        setupUI()
        passRequest()
    }

    @IBAction func toggleFavorite() {
        isFavorite.toggle()
        setStatusForFavoriteButton()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite)
    }

    private func passRequest() {
        let request = CourseDetails.ShowDetails.Request(course: course)
        interactor?.provideCourseDetails(request: request)
    }

    private func setupUI() {
        }
    
        if let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl) {
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

    extension CourseDetailsViewController: CourseDetailsDisplayLogic {
        func displayCourseDetails(viewModel: CourseDetails.ShowDetails.ViewModel) {
            courseNameLabel.text = viewModel.courseName
            numberOfLessonsLabel.text = viewModel.numberOfLessons
            numberOfTestsLabel.text = viewModel.numberOfTests
        }
    }
}
