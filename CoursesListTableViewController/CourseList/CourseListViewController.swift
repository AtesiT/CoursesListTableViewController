import UIKit

protocol CourseListDisplayLogic: AnyObject {
    func displayCourses(viewModel: CourseList.ShowCourses.ViewModel) {
        
    }
    
    import UIKit
    
    class CourseListViewController: UIViewController {
        
        @IBOutlet var tableView: UITableView!
        
        var interactor: CourseListBusinessLogic?
        var router: (NSObjectProtocol & CourseListRoutingLogic & CourseListDataPassing)?
        
        private var activityIndicator: UIActivityIndicatorView
        private var courses: [Course] = []
        
        // MARK: View lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            CourseListConfigurator.shared.configure(with: self)
            tableView.rowHeight = 100
            activityIndicator = showActivityIndicator(in: view)
            setupNavigationBar()
            getCourses()
            showCourses()
        }
        
        // MARK: Routing
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let detailsVC = segue.destination as? CourseDetailsViewController
            detailsVC?.course = sender as? Course
        }
        
        private func showCourses() {
            interactor?.fetchCourses()
        }
        
        private func getCourses() {
            NetworkManager.shared.fetchData() { courses in
                self.courses = courses
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                    self.tableView?.reloadData()
                }
            }
        }
        
        private func setupNavigationBar() {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .blue
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
}
    
// MARK: - UITableViewDataSource
extension CourseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        let course = courses[indexPath.row]
        cell.configure(with: course)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = courses[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: course)
    }
}

// MARK: - CourseListDisplayLogic
extension CourseListViewController: CourseListDisplayLogic {
    func displayCourses(viewModel: CourseList.ShowCourses.ViewModel) {

    }
}

