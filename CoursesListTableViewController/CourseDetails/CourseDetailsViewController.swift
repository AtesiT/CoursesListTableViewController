import UIKit
protocol CourseDetailsDisplayLogic: AnyObject {
    func displayCourseDetails(viewModel: CourseDetails.ShowDetails.ViewModel)
    func displayFavoriteButtonStatus(viewModel: CourseDetails.SetFavoriteStatus.ViewModel)
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
        passRequest()
    }
    
    @IBAction func toggleFavorite() {
        interactor?.setFavoriteStatus()
    }
    
    private func passRequest() {
        let request = CourseDetails.ShowDetails.Request(course: course)
        interactor?.provideCourseDetails(request: request)
    }
}

extension CourseDetailsViewController: CourseDetailsDisplayLogic {
    func displayCourseDetails(viewModel: CourseDetails.ShowDetails.ViewModel) {
        courseNameLabel.text = viewModel.courseName
        numberOfLessonsLabel.text = viewModel.numberOfLessons
        numberOfTestsLabel.text = viewModel.numberOfTests
        courseImage.image = UIImage(data: viewModel.imageData)
        favoriteButton.tintColor = viewModel.isFavorite ? .systemRed : .systemGray
    }
    
    func displayFavoriteButtonStatus(viewModel: CourseDetails.SetFavoriteStatus.ViewModel) {
        favoriteButton.tintColor = viewModel.isFavorite ? .systemRed : .systemGray
    }
}
