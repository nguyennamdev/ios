//
//  RatingControl.swift
//  DemoSaveDataWithSQL
//
//  Created by Nguyen Nam on 12/27/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK : Properties
    
    private var ratingButtons = [UIButton]()
    var rating = 0{
        didSet{
            updateButtonsSelectionStates()
        }
    }
    
    @IBInspectable var starSize:CGSize = CGSize(width: 44, height: 44){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount:Int = 5{
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
    
    // MARK : Private Method
    
    private func setupButtons(){
        
        // clear any existing buttons
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledstar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptystar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {

            //create the button
            
            let button = UIButton()
            // add constaints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            // add button to stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            
            ratingButtons.append(button)
        }
        
        updateButtonsSelectionStates()
    }
    
    @objc private func ratingButtonTapped(button:UIButton){
        guard let index = ratingButtons.index(of: button) else {
            return
        }
        
        // Caculate the rating of the selected button
        
        let selectedRating = index + 1
        if selectedRating == rating{
            rating = 0
        }else{
            rating = selectedRating
        }
        
    }
    
    private func updateButtonsSelectionStates(){
        for (index,button) in ratingButtons.enumerated(){
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
        }
    }
}
