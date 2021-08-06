//
//  ViewController.swift
//  SideMenu
//
//  Created by admin on 06.08.2021.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addChildsVC()
    }
    
    private func addChildsVC(){
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapButtonMenu() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { [weak self](done) in
                if(done){
                    self?.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self](done) in
                if(done){
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
    
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOption) {
        toggleMenu(completion: nil)
        switch  menuItem {
        case .home:
            self.resetToHome()
        case .info:
            self.addInfo()
        case .appRating:
            break
        case .shareApp:
            break
        case .setting:
            break
        }
    }
    
    func addInfo(){
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.didMove(toParent: homeVC)
        
        vc.view.frame = view.frame
        homeVC.title = vc.title
    }
    
    func resetToHome() {
        guard parent != nil else {
        return
        }
        infoVC.willMove(toParent: nil)
        infoVC.removeFromParent()
        infoVC.view.removeFromSuperview()
        homeVC.title = "Home"
    }
}
