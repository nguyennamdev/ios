//
//  ViewController.swift
//  RxSwiftStarted
//
//  Created by Nguyen Nam on 1/22/18.
//  Copyright © 2018 Nguyen Nam. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ChameleonFramework


class ViewController: UIViewController {
    
    var circleView:UIView = {
        let view = UIView()
        return view
    }()
    
     var circleViewModel:CircleViewModel = CircleViewModel()

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        setupCircleView()
        
    }
    
    func setupCircleView() {
        // Add circle view 
        circleView.frame = CGRect(origin: view.center, size: CGSize(width: 100, height: 100))
        circleView.layer.cornerRadius = 50
        circleView.backgroundColor = UIColor.green
        circleView.center = view.center
        circleView.isUserInteractionEnabled = true
        view.addSubview(circleView)
        
        // Bind the center point of the circle view to centerObservable 
        circleView
            .rx.observe(CGPoint.self, "center")
            .bind(to: circleViewModel.centerVariable)
            .addDisposableTo(DisposeBag())
        
        // Subscribe to backgroundColor to get new colors from the view model
        circleViewModel.backgroundColorObservable
            .subscribe(onNext: { [weak self] backgoundColor in
                UIView.animate(withDuration: 0.1, animations: {
                    self?.circleView.backgroundColor = backgoundColor
                    // Try to get complementary color for given backgound color
                    let viewBackgoundColor = UIColor(complementaryFlatColorOf: backgoundColor)
                    // If it is different that the color
                    if viewBackgoundColor != backgoundColor{
                        self?.view.backgroundColor = viewBackgoundColor
                    }
                })
            }).addDisposableTo(DisposeBag())
        
       
        // Add gesture recognier to circle view
        let panGestureRecognier = UIPanGestureRecognizer(target: self, action: #selector(circleMoved))
        circleView.addGestureRecognizer(panGestureRecognier)
    }
    
    func circleMoved(_ panGesture:UIPanGestureRecognizer){
        let location = panGesture.location(in: view)
        UIView.animate(withDuration: 0.1) { 
            self.circleView.center = location
        }
    }
}

