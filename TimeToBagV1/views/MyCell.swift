//
//  MyCell.swift
//  TimeToTravel
//
//  Created by Admin on 09/12/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
protocol MyCellDelegate{
    func onCellClicked(index:Int)
}
class MyCell: UITableViewCell {

    var index:Int?
    @IBOutlet weak var cellBackground: UIImageView!
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var bottomLeftLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!
    var delegate:MyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform=CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform=CGAffineTransform.identity
        }, completion: {bool in
            self.delegate?.onCellClicked(index: self.index!)

        })

        super.touchesBegan(touches, with: event)
    }
	

    
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth=borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor=borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat=0{
        didSet{
            self.layer.cornerRadius=cornerRadius
        }
    }
    
  

}
