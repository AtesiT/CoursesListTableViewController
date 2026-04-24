import UIKit

protocol CourseListViewInputProtocol: AnyObject {
    func display(courses: [Course])
}

final class CourseListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let configurator: CourseListConfiguratorInputProtocol = CourseListConfigurator()
    
    private var activityIndicator: UIActivityIndicatorView?
    private var courses: [Course] = []
    
    private var viewModel: CourseListViewModelProtcol! {
        didSet {
            viewModel.fetchCourses { [weak self] in
                //  Так как это начальный VC, то необязательно список захвата реализовывать
                self?.tableView.reloadData()
                self?.activityIndicator?.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(withView: self)
        viewModel = CourseListViewModel()
        tableView.rowHeight = 100
        activityIndicator = showActivityIndicator(in: view)
        setupNavigationBar()
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? CourseDetailsViewController else { return }
        detailVC.viewModel = sender as? Course
    }
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
//  MARK: - TableViewDataSource
extension CourseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configure(with: course)
        
        return cell
    }
}
    
//  MARK: - TableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let courseDetailsViewModel = viewModel.getCourseDetailsViewModel(at: indexPath)
        performSegue(withIdentifier: "showDetails", sender: courses)
    }
}

extension CourseListViewController: CourseListViewInputProtocol {
    func display(courses: [Course]) {
        self.courses = courses
        tableView.reloadData()
        activityIndicator?.stopAnimating()
    }
}
