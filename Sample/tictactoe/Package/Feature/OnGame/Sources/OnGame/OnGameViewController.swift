//
//  OnGameViewController.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import RVB
import RxSwift
import RxCocoa
import ReactorKit
import RxDataSources
import Game
import Resource

public protocol OnGameControllable: UIViewControllable {
    var disposeBag: DisposeBag { get }
    
    /// Exit game event.
    var exit: Observable<Void> { get }
    /// Game ended event.
    var gameEnded: Observable<GameResult> { get }
}

final class OnGameViewController: UIViewController, View, OnGameControllable {
    typealias OnGameSectionModel = SectionModel<Void, GamePiece?>
    
    // MARK: - View
    private let root = OnGameView()
    
    private var pieceImageView: UIImageView { root.pieceImageView }
    private var turnLabel: UILabel { root.turnLabel }
    private var boardCollectionView: UICollectionView { root.boardCollectionView }
    private var exitButton: UIButton { root.exitButton }

    // MARK: - Property
    var router: (any OnGameRoutable)?
    var disposeBag = DisposeBag()
    
    private let _gameEnded = PublishRelay<GameResult>()
    
    private let dataSource = RxCollectionViewSectionedReloadDataSource<OnGameSectionModel> { dataSource, collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.name, for: indexPath) as? BoardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(piece: item)
        
        return cell
    }

    // MARK: - Initializer

    // MARK: - Lifecycle
    override func loadView() {
        view = root
    }
    
    func bind(reactor: OnGameViewReactor) {
        // MARK: State
        // Board
        reactor.state.map(\.board)
            .distinctUntilChanged()
            .map { $0.map { OnGameSectionModel(model: Void(), items: $0) } }
            .bind(to: boardCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // Turn
        let turn = reactor.state.map(\.turn)
            .distinctUntilChanged()
            .share(replay: 1)
        
        let players = Observable.combineLatest(
            reactor.state.map(\.playerA),
            reactor.state.map(\.playerB)
        )
            .share(replay: 1)
        
        // Turn title
        turn.withLatestFrom(players) { turn, players -> Player in
            let (playerA, playerB) = players
            switch turn {
            case .a:
                return playerA
                
            case .b:
                return playerB
            }
        }
            .map { $0.name }
            .map { String(format: R.Localizable.onGameTurnTitle, $0) }
            .bind(to: turnLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Turn piece image
        turn.map {
            switch $0 {
            case .a:
                return UIImage(systemName: "circle")
                
            case .b:
                return UIImage(systemName: "xmark")
            }
        }
            .bind(to: pieceImageView.rx.image)
            .disposed(by: disposeBag)
        
        // Game result
        reactor.pulse(\.$didGameEnd)
            .compactMap { $0 }
            .withLatestFrom(players) { ($0, $1.0, $1.1) }
            .subscribe(onNext: { [weak self] in
                self?.presentGameResultAlert(
                    result: $0,
                    playerA: $1,
                    playerB: $2
                )
            })
            .disposed(by: disposeBag)
        
        // Error
        reactor.pulse(\.$error)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] in
                self?.presentErrorAlert(error: $0) })
            .disposed(by: disposeBag)
        
        // MARK: Action
        boardCollectionView.rx.itemSelected
            .map { .place(at: ($0.section, $0.item)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func presentGameResultAlert(
        result: GameResult,
        playerA: Player,
        playerB: Player
    ) {
        let message: String
        switch result {
        case let .end(winner):
            switch winner {
            case .a:
                message = String(format: R.Localizable.onGameGameEndAlertWinnerMessage, playerA.name)
                
            case .b:
                message = String(format: R.Localizable.onGameGameEndAlertWinnerMessage, playerB.name)
            }
            
        case .draw:
            message = R.Localizable.onGameGameEndAlertDrawMessage
        }
        
        let viewController = UIAlertController(
            title: R.Localizable.onGameGameEndAlertTitle,
            message: message,
            preferredStyle: .alert
        )
        
        viewController.addAction(
            .init(
                title: R.Localizable.okay,
                style: .default
            ) { [weak self] _ in
                self?._gameEnded.accept(result)
            }
        )
        
        present(viewController, animated: true)
    }
    
    private func presentErrorAlert(error: Error) {
        let viewController = UIAlertController(
            title: R.Localizable.errorTitle,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        viewController.addAction(
            .init(
                title: R.Localizable.okay,
                style: .default
            )
        )
        
        present(viewController, animated: true)
    }
}

extension OnGameViewController {
    var exit: Observable<Void> {
        exitButton.rx.tap
            .asObservable()
    }
    
    var gameEnded: Observable<GameResult> {
        _gameEnded.asObservable()
    }
}
