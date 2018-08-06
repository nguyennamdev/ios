//
//  ViewController.swift
//  DemoAudible
//
//  Created by Nguyen Nam on 10/17/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , LoginControllerDelegate{
    
    let pageCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection  = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        return cv
    }()
    
    var pageControl:UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor.orange
        pc.pageIndicatorTintColor = UIColor.lightGray
       return pc
    }()
    let skipButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(skipPage), for: .touchUpInside)
        return button
    }()
    
    
    let nextButton:UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    

    
    let pages:[Page] = {
        let firstPage = Page.init(title: "Share a great listen", message: "It's free to send your books to the people in your life . Every recipient's first book in on us .", imageName: "page1")
        let secoundPage = Page.init(title: "Send from your library", message: "Top the More menu next to any book . Choose \"Send this Book\"", imageName: "page2")
        
        let thridPage = Page.init(title: "Send from the player ", message: "Tap the More menu in the upper corner .Choose \"Send this book\"", imageName: "page3")
        
        return [firstPage,secoundPage,thridPage]
    }()
    
    private let cellId = "cellId"
    private let loginCellId = "loginCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(pageCollectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        pageCollectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        pageCollectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
        
        
        pageCollectionView.anchorWithConstants(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        // page control
        pageControl.anchorWithConstants(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0)
        pageControl.numberOfPages = pages.count + 1
        
        // skip button
        skipButton.anchorWithConstants(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil)
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        // next button 
        nextButton.anchorWithConstants(top: view.topAnchor, left:nil, bottom: nil, right: view.rightAnchor)
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        observerKeyboardNotifications()
    }
    
    private func observerKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardShow(){
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1 , initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                 self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
    }
    
    @objc private func keyboardHide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: { 
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc private func nextPage(){
        
        // current page = last page
        if pageControl.currentPage == pages.count{
           return
        }
        // current page = second last page
        if pageControl.currentPage == pages.count - 1{
            pageControl.isHidden = true
            skipButton.isHidden = true
            nextButton.isHidden = true
        }
        let indexPath = IndexPath(item: pageControl.currentPage  + 1, section: 0)
        pageCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    @objc private func skipPage(){
        // only need to lines to do this
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.loginDelegate = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        cell.page = pages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.pageCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        print(pageNumber)
        
        if pageNumber == pages.count {
            pageControl.isHidden = true
            skipButton.isHidden = true
            nextButton.isHidden = true
            UIView.animate(withDuration: 0.5, animations: { 
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        else{
            skipButton.isHidden = false
            nextButton.isHidden = false
            pageControl.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func finishIsLogin() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else {
            return
        }
        mainNavigationController.viewControllers = [HomeViewController()]
        UserDefaults.standard.setIsLoggedIn(value: true)
        dismiss(animated: true, completion: nil)
    }
    
    
}

