//
//  BlogList.swift
//  SearchBlog
//
//  Created by YONGCHEOL LEE on 2021/12/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BlogList: UITableView {
    let disposeBag = DisposeBag()
    
    let headerView = FilterView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50)))
    
    // MainViewController -> BlogListView
    let cellData = PublishSubject<[BlogListCellData]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        cellData
            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items) { tableview, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableview.dequeueReusableCell(withIdentifier: "BlogListCell", for: indexPath) as! BlogListCell
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        backgroundColor = .white
        separatorStyle = .singleLine
        rowHeight = 100
        tableHeaderView = headerView
        register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
        
    }
}
