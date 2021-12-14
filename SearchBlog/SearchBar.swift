//
//  SearchBar.swift
//  SearchBlog
//
//  Created by YONGCHEOL LEE on 2021/12/15.
//

import UIKit
import RxSwift
import RxCocoa


class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    
    // SearchBar Button tap event
    let searchButtonTapped = PublishRelay<Void>()
    
    // send SearchBar's String to external size
    var shouldLoadResult = Observable<String>.of()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bind() {
        // searchBar search button tapped
        // button tapped
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        
    }
}
