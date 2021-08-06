import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOption)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOption: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case setting = "Setting"
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .info:
                return "airplane"
            case .appRating:
                return "star"
            case .shareApp:
                return "message"
            case .setting:
                return "gear"
            }
        }
    }
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top
                                 , width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOption.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        let selectedCellView = UIView()
        selectedCellView.backgroundColor = .red
        cell.selectedBackgroundView = selectedCellView
        cell.imageView?.image = UIImage(systemName: MenuOption.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOption.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
