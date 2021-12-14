//
//  AlertActionConvertible.swift
//  SearchBlog
//
//  Created by YONGCHEOL LEE on 2021/12/15.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
