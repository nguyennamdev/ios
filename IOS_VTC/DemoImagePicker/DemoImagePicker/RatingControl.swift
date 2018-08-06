//
//  RatingControl.swift
//  DemoImagePicker
//
//  Created by Nguyen Nam on 8/4/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    private var ratingButtons = [UIButton]()
    var rating = 0{
        didSet{
            updateButtoSelectionState()
        }
    }
    
   var starSize:CGSize = CGSize(width: 40, height: 40){
        didSet{
            setupButtons()
        }
    }
   var starCount:Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @objc private func ratingButtonTapped(button:UIButton){
        print("Press")
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        if selectedRating == rating{
            rating  = 0
        }
        else{
            rating = selectedRating
        }
    }
    
    private func updateButtoSelectionState(){
        for (index, item) in ratingButtons.enumerated() {
            item.isSelected = index < rating
        }
    }
    
    private func setupButtons(){
        
         // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // load image buttons 
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "flledstar", in: bundle, compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptystar", in: bundle, compatibleWith: self.traitCollection)
        
        let highlighStar = UIImage(named: "highlighStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            
            // create the button
            let button = UIButton()
            button.setImage(filledStar, for: .selected)
            button.setImage(emptyStar, for: .normal)
            button.setImage(highlighStar, for: .highlighted)
            // add constraints
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // setup action button
            button.addTarget(self, action:#selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // add button to stack
            addArrangedSubview(button)
            // add button to collection button rating
            ratingButtons.append(button)
        }
        
        updateButtoSelectionState()
    }
}
