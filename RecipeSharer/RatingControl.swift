//
//  RatingControl.swift
//  RecipeSharer
//
//  Created by Christiaan van Bemmel on 14/06/2019.
//  Copyright © 2019 Christiaan van Bemmel. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    var imageBundle: Bundle?
    var filledStar: UIImage?
    var emptyStar: UIImage?
    var highlightedStar: UIImage?
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            clearButtons()
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            clearButtons()
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
    
    private func setupButton(index: Int) -> UIButton {
        let button = UIButton()
        button.setImage(emptyStar, for: .normal)
        button.setImage(filledStar, for: .selected)
        button.setImage(highlightedStar, for: .highlighted)
        button.setImage(highlightedStar, for: [.highlighted, .selected])
        
        // Some button contraints...
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        button.accessibilityLabel = "Set \(index + 1) star rating"
        
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        addArrangedSubview(button)
        
        return button
    }
    
    private func setupButtons() {
        setupImages()
        
        for index in 0..<starCount {
            ratingButtons.append(setupButton(index: index))
        }
        
        updateButtonSelectionStates()
    }
    
    private func setupImages() {
        imageBundle = Bundle(for: type(of: self))
        filledStar = UIImage(named: "filledStar", in: imageBundle, compatibleWith: self.traitCollection)
        emptyStar = UIImage(named: "emptyStar", in: imageBundle, compatibleWith: self.traitCollection)
        highlightedStar = UIImage(named: "highlightedStar", in: imageBundle, compatibleWith: self.traitCollection)
    }
    
    private func clearButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
    }
    
    private func generateHintString(index: Int) -> String? {
        return rating == index + 1 ? "Tap to reset the rating to zero." : nil
    }
    
    private func generateValueString() -> String {
        if (rating == 0) {
            return "No rating set."
        }
        if (rating == 1) {
            return "1 star set."
        }
        return "\(rating) stars set."
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            button.accessibilityHint = generateHintString(index: index)
            button.accessibilityValue = generateValueString()
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the RatingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
}
