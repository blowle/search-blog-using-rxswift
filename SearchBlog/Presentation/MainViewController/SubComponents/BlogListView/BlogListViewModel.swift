//
//  BlogListViewModel.swift
//  SearchBlog
//
//  Created by yongcheol Lee on 2021/12/20.
//

import RxSwift
import RxCocoa


struct BlogListViewModel {
    let filterViewModel = FilterViewModel()
    
    // MainViewController -> BlogListView
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
