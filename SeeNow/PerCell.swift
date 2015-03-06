

import UIKit

class PerCell: UITableViewCell {

    var mainView = UIView(frame: CGRectMake(0, 0, 1024, 80))
    var leftView = UIView(frame: CGRectMake(0,8,40,72))
    var rightView = UIView(frame: CGRectMake(40,8,969,72))
    var perImageView = UILabel(frame: CGRectMake(10, 4, 64, 64))
    var lblName = UILabel(frame: CGRectMake(100, 5, 460, 25))
    var DetailLabel = UILabel(frame: CGRectMake(100, 35, 240, 30))
    var detaillabel1 = UILabel(frame: CGRectMake(345, 35, 240, 30))
    var button1 = UIButton(frame: CGRectMake(852, 21, 29, 29))
    var button2 = UIButton(frame: CGRectMake(891, 21, 29, 29))
    var button3 = UIButton(frame: CGRectMake(930, 21, 29, 29))
    var button4 = UIButton(frame: CGRectMake(813, 21, 29, 29))
    var b2v = 0
    var b3v = 0
    let grayIcon = UIImage(named: "grayicon.png")
    let leftImageView = UIImageView(frame: CGRectMake(5, 21, 29, 29))
    override func awakeFromNib() {
        super.awakeFromNib()
        //头像
        leftImageView.image = grayIcon
        leftView.addSubview(leftImageView)
        //perImageView.image = grayIcon
        perImageView.layer.cornerRadius = 32
        perImageView.layer.masksToBounds = true
        rightView.addSubview(perImageView)
        lblName.font = UIFont(name: "Arial-BoldItalicMT", size: 15)
        rightView.addSubview(lblName)
        rightView.addSubview(DetailLabel)
        DetailLabel.font = UIFont(name: "Arial-BoldItalicMT", size: 12)

        rightView.addSubview(detaillabel1)
        detaillabel1.font = UIFont(name: "Arial-BoldItalicMT", size: 12)

        button1.backgroundColor = UIColor(patternImage: UIImage(named: "eye.png")!)
        button4.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
        if b2v == 0 {
            button2.backgroundColor = UIColor(patternImage: UIImage(named: "graypen.png")!)
        }else{
            //button2.backgroundColor = UIColor(patternImage: UIImage(named: "bulepen.png")!)
        }
        if b3v == 0 {
            button3.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
        }else{
            //button3.backgroundColor = UIColor(patternImage: UIImage(named: "greendh.png")!)
        }
        
        rightView.addSubview(button1)
        rightView.addSubview(button2)
        rightView.addSubview(button3)
        rightView.addSubview(button4)
        rightView.backgroundColor = UIColor(patternImage: UIImage(named: "tiaobg.png")!)
        mainView.addSubview(leftView)
        mainView.addSubview(rightView)
        mainView.layer.shadowOffset = CGSize(width: 3, height: 6)
        self.addSubview(mainView)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
