//
//  PhotoWallCollectionViewController.swift
//  GridPhotoWall
//
//  Created by 蔡尚諺 on 2021/12/24.
//

import UIKit
import Kingfisher

class PhotoWallCollectionViewController: UICollectionViewController {
    
    var photos = [PhotoResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
        fetchPhotos() //抓照片
        configureCellSize() //調整cell大小間距
        
    }
    
    @IBSegueAction func toBigPhoto(_ coder: NSCoder) -> BigPhotoViewController? {
        let photo = photos[(collectionView.indexPathsForSelectedItems?.first?.row)!]
        return BigPhotoViewController(photo: photo, coder: coder)
    }
    
    func configureCellSize() {
        let itemSpace: CGFloat = 3
        let columnCount: CGFloat = 3
        
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount-1)) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
        
    }
    
    func fetchPhotos(){
        if let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=100"){
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data,
                   let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200,
                   error == nil{
                    do {
                        let decoder = JSONDecoder()
                        self.photos = try decoder.decode([PhotoResponse].self, from: data)
                        //丟到主執行緒作業
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    } catch  {
                        print(error)
                    }
                }else{
                    print(error)
                }
            }.resume()
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCollectionViewCell.self)", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        let image = UIImage.animatedImageNamed("dog-", duration: 3)
        cell.photoImageView.kf.setImage(with: photo.download_url,placeholder: image )
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let identifier = "toBigPhoto"
        performSegue(withIdentifier: identifier, sender: nil)
    }
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
