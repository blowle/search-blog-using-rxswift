//
//  FilterViewModel.swift
//  SearchBlog
//
//  Created by yongcheol Lee on 2021/12/20.
//

import RxCocoa
import RxSwift

struct FilterViewModel {
    // FilterView 외부에서 관찰
    let sortButtonTapped = PublishRelay<Void>()
}
