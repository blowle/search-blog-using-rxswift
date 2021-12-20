//
//  SearchBarViewModel.swift
//  SearchBlog
//
//  Created by yongcheol Lee on 2021/12/20.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    let shouldLoadResult: Observable<String>
    let searchButtonTapped = PublishRelay<Void>()

    
    init() {
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
}
