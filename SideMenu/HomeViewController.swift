import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapButtonMenu()
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(barButtonTapped))
    }

    @objc func barButtonTapped() {
        delegate?.didTapButtonMenu()
    }

}
