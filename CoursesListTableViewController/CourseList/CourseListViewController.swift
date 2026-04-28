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
        private var rows: [CourseCellViewModelProtcol] = []
        
        // MARK: View lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            CourseListConfigurator.shared.configure(with: self)
            activityIndicator = showActivityIndicator(in: view)
            setupNavigationBar()
            getCourses()
            showCourses()
        }
        
        // MARK: Routing
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let scene = segue.identifier {
                let selector = NSSelectorFromString ("routeTo\(scene)WithSegue:")
                if let router = router, router.responds (to: selector) {
                    router.perform(selector, with: segue)
                }
            }
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
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rows[indexPath.row].height
    }
}

// MARK: - CourseListDisplayLogic
extension CourseListViewController: CourseListDisplayLogic {
    func displayCourses(viewModel: CourseList.ShowCourses.ViewModel) {
        rows = viewModel.rows
        activityIndicator?.stopAnimating()
        tableView.reloadData()
    }
}

