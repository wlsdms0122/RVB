//
//  OnGameView.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import SnapKit
import Util
import Resource

final class OnGameView: UIView {
    // MARK: - View
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.font = .preferredFont(forTextStyle: .largeTitle)
        view.textColor = .label
        view.textAlignment = .center
        view.text = R.Localizable.onGameTitle
        
        return view
    }()
    
    let pieceImageView: UIImageView = {
        let view = UIImageView(image: .init(systemName: "circle"))
        view.tintColor = .systemGray
        
        return view
    }()
    
    let turnLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title2)
        view.textColor = .systemGray
        view.textAlignment = .center
        
        return view
    }()
    
    private let turnStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 8
        
        return view
    }()
    
    private let titleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 4
        
        return view
    }()
    
    let boardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.backgroundView = UIImageView(image: R.Image.board)
        
        view.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.name)
        
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 24
        
        return view
    }()
    
    private let contentView = UIView()
    
    let exitButton: UIButton = {
        let view = UIButton(configuration: .tinted())
        view.setTitle(R.Localizable.onGameExitButtonTitle, for: .normal)
        
        return view
    }()

    // MARK: - Property

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    // MARK: - Public

    // MARK: - Private
    private func setUp() {
        setUpLayout()
        setUpState()
        setUpAction()
    }
    
    private func setUpLayout() {
        [
            pieceImageView,
            turnLabel
        ]
            .forEach { turnStackView.addArrangedSubview($0) }
        
        pieceImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        [
            titleLabel,
            turnStackView
        ]
            .forEach { titleStackView.addArrangedSubview($0) }
        
        [
            titleStackView,
            boardCollectionView
        ]
            .forEach { contentStackView.addArrangedSubview($0) }
        
        boardCollectionView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
                .inset(16)
                .priority(.high)
            $0.width.equalTo(boardCollectionView.snp.height)
        }
        
        [
            contentStackView
        ]
            .forEach { contentView.addSubview($0) }
        
        contentStackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview()
                .offset(16)
            $0.width.height.equalToSuperview()
                .priority(.high)
            $0.center.equalToSuperview()
        }
        
        [
            contentView,
            exitButton
        ]
            .forEach { addSubview($0) }
        
        contentView.snp.makeConstraints {
            $0.top.trailing.leading
                .equalTo(safeAreaLayoutGuide)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom)
            $0.trailing.leading.equalTo(safeAreaLayoutGuide)
                .inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide)
                .inset(16)
            $0.height.equalTo(48)
        }
    }
    
    private func setUpState() {
        backgroundColor = .systemBackground
    }
    
    private func setUpAction() {
        
    }
}
