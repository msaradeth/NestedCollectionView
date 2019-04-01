//
//  CatVC.swift
//  CatApiCollectionView
//
//  Created by Mike Saradeth on 3/27/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit
import RxSwift


class VerticalVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: VViewModel!
    
    static func createWith(title: String, viewModel: VViewModel) -> VerticalVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VerticalVC") as! VerticalVC
        vc.title = title
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.loadData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }            
        }
    }
}

// MARK: UITableViewDataSource and UITableViewDelegate
extension VerticalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: VTableViewCell.cellIdentifier, for: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension VerticalVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case let cell as VTableViewCell:
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            
        default:
            break
        }
    }
}




// MARK: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension VerticalVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // get UICollectionViewFlowLayout from collectionViewLayout
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let numberOfColumns: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
        let availableWidth = collectionView.bounds.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
        
        let cellWidth = availableWidth / numberOfColumns
        return CGSize(width: cellWidth, height: 350)
    }
}


extension VerticalVC: UICollectionViewDelegate {
    
}

extension VerticalVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count > 0 ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections.count > 0 ? viewModel.sections[section].count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HCollectionViewCell.cellIdentifier, for: indexPath) as! HCollectionViewCell
        
        cell.configure(item: viewModel[indexPath])
        
        return cell
        
    }
    
}
