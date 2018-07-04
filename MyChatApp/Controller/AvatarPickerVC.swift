//
//  AvatarPickerVC.swift
//  MyChatApp
//
//  Created by hossein shademany on 2/11/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    // outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabbar: UISegmentedControl!
    
    //defaulte properties
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    func config(){
        //collection setup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "AvatarCell", bundle: nil), forCellWithReuseIdentifier: "avatarCellId")
    }
    //number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 27
    }
    // size of cells
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        var numberOfColums : CGFloat = 4
        if UIScreen.main.bounds.width < 320 {
            numberOfColums = 3
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimention = (((collectionView.bounds.width - padding) - (numberOfColums - 1) * spaceBetweenCells)) / numberOfColums
        return CGSize(width: cellDimention, height: cellDimention)
    }
    // content of cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCellId", for: indexPath) as? AvatarCell{
            cell.bind(index: indexPath.item, avatarType: avatarType)
            return cell
        }
        return AvatarCell()
    }
    // item clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if avatarType == .dark {
            UserData.instance.updateAvatarName(avatarName: "dark\(indexPath.item)")
        }else{
            UserData.instance.updateAvatarName(avatarName: "light\(indexPath.item)")
        }
        dismiss(animated: true, completion: nil)
    }
    // tabbar change
    @IBAction func tabBar(_ sender: Any) {
        if tabbar.selectedSegmentIndex == 0 {
            avatarType = .dark
        }else{
            avatarType = .light
        }
        collectionView.reloadData()
    }
    //dismiss button pressed
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 

}
