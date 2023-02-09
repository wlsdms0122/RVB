//
//  BoardCollectionViewCell.swift
//  
//
//  Created by JSilver on 2022/12/29.
//

import UIKit
import SnapKit
import Game

final class BoardCollectionViewCell: UICollectionViewCell {
    // MARK: - View
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .label
        
        return view
    }()

    // MARK: - Property

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let superview else { return layoutAttributes }

        let edge = min(superview.bounds.width, superview.bounds.height)

        layoutAttributes.size = .init(
            width: floor(edge / 3),
            height: floor(edge / 3)
        )

        return layoutAttributes
    }

    // MARK: - Public
    func configure(piece: GamePiece?) {
        switch piece {
        case .a:
            imageView.image = .init(systemName: "circle")
            
        case .b:
            imageView.image = .init(systemName: "xmark")
            
        default:
            imageView.image = nil
        }
    }

    // MARK: - Private
    private func setUp() {
        setUpLayout()
        setUpState()
        setUpAction()
    }
    
    private func setUpLayout() {
        [
            imageView
        ]
            .forEach { contentView.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(16)
        }
    }
    
    private func setUpState() {
        
    }
    
    private func setUpAction() {
        
    }
}
