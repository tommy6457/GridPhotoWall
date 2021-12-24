//
//  BigPhotoViewController.swift
//  GridPhotoWall
//
//  Created by 蔡尚諺 on 2021/12/24.
//

import UIKit

class BigPhotoViewController: UIViewController {
    
    var photo: PhotoResponse!
    
    @IBOutlet weak var bigPhotoImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    init?(photo: PhotoResponse? = nil, coder: NSCoder) {
        super.init(coder: coder)
        self.photo = photo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photo = photo {
            bigPhotoImageView.kf.setImage(with: photo.download_url,placeholder: UIImage(named: "loading"))
            authorLabel.text = photo.author
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
