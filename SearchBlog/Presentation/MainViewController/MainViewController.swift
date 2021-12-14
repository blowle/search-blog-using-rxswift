//
//  MainViewController.swift
//  SearchBlog
//
//  Created by YONGCHEOL LEE on 2021/12/15.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
     let listView = BlogList()
     let searchBar = SearchBar()
    
    let alertActionTapped = PublishRelay<AlertAction>()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        let alertSheetForSorting = listView.headerView.sortButtonTapped
            .map { _ -> Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        alertSheetForSorting
            .asSignal(onErrorSignalWith: .empty())
            .flatMapLatest { alert -> Signal<AlertAction> in
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                
                return self.presentAlertController(alertController, actions: alert.actions)
            }
            .emit(to: alertActionTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "블로그 검색"
        view.backgroundColor = .white
    }
    
    private func layout() {
        [searchBar, listView].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// Alert
extension MainViewController {
    typealias Alert = (title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style)
    
    enum AlertAction: AlertActionConvertible {
        case title, datetime, cancel
        case confirm
        
        var title: String {
            switch self {
            case .title:
                return "Title"
            case .datetime:
                return "Datetime"
            case .cancel:
                return "취소"
            case .confirm:
                return "확인"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .title, .datetime:
                return .default
            case .cancel, .confirm:
                return .cancel
            }
        }
    }
    
    func presentAlertController<Action: AlertActionConvertible>(
        _ alertControlller: UIAlertController, actions: [Action]) -> Signal<Action> {
        if actions.isEmpty { return .empty() }
        
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            for action in actions {
                alertControlller.addAction(
                    UIAlertAction(
                        title: action.title,
                        style: action.style,
                        handler: { _ in
                            observer.onNext(action)
                            observer.onCompleted()
                        }
                    )
                )
            }
            self.present(alertControlller, animated: true, completion: nil)
            
            return Disposables.create {
                alertControlller.dismiss(animated: true, completion: nil)
            }
        }
        .asSignal(onErrorSignalWith: .empty())
    }
}
