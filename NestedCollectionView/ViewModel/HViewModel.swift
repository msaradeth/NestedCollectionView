//
//  CatViewModel.swift
//  CatApiCollectionView
//
//  Created by Mike Saradeth on 3/27/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import RxSwift


class HViewModel: NSObject {
    let disposeBag = DisposeBag()
    var items: [Cat]
    
    init(items: [Cat]) {
        self.items = items
    }
    
    subscript(index: Int) -> Cat {
        return items[index]
    }
    
    deinit {
        print("deinit - HViewModel")
    }
}
