import Foundation
import UIKit

open class Intro: UIView {
    let inorganicView = UIView(frame: CGRect(x: 250, y: 0, width: 250, height: 600))
    let organicView  = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 600))
    var imageOrganicArray:[UIImageView] = []
    var imageInorganicArray:[UIImageView] = []
    let title = UILabel(frame: CGRect(x: 160, y: 20, width: 200, height: 150))
    let descript = UILabel(frame: CGRect(x: 100, y: 70, width: 300, height: 150))
    

    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        inorganicView.backgroundColor =  UIColor(red:64.0/255.0, green:80.0/255.0 ,blue:89.0/255.0 , alpha:1.0)
        organicView.backgroundColor =  UIColor(red:115.0/255.0, green:176.0/255.0 ,blue:111.0/255.0 , alpha:1.0)
        addSubview(inorganicView)
        addSubview(organicView)
        animationsOrganic()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func createViews(){
   
    
       
        title.text = "Chitíshe"
        title.font = UIFont(name: "Helvetica", size: 50)
        title.textColor = UIColor.white
        
        descript.text = "Chitíshe will help you sort the waste into organic and inorganic"
        
        descript.textColor = UIColor.white
        descript.numberOfLines = 2
        descript.textAlignment = NSTextAlignment.center
        descript.font = UIFont(name: "Helvetica", size: 16)
        
        title.center.x -= organicView.bounds.width + 70
        
        UIView.animate(withDuration: 0.7, animations: {
            self.title.center.x += self.organicView.bounds.width + 70
        })
        descript.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.descript.alpha = 1
        }, completion: nil)
        
        organicView.addSubview(title)
        organicView.addSubview(descript)

    }
    
    func animationsOrganic(){
        let egg = UIImageView(image: UIImage(named: "001-egg.png"))
        let vegetables = UIImageView(image: UIImage(named: "003-vegetables.png"))
        let banana = UIImageView(image: UIImage(named: "005-banana.png"))
        
        let bathroom = UIImageView(image: UIImage(named: "002-bathroom.png"))
        let can = UIImageView(image: UIImage(named: "004-can.png"))
        let water = UIImageView(image: UIImage(named: "006-water.png"))
        
        egg.center.y += 250
        egg.center.x += 200
        vegetables.center.y += 250
        vegetables.center.x += 200
        banana.center.y += 250
        banana.center.x += 200
        bathroom.center.y += 250
        bathroom.center.x += 200
        can.center.y += 250
        can.center.x += 200
        water.center.y += 250
        water.center.x += 200


        UIView.animateKeyframes(withDuration: 2.5, delay: 0.8, options: [], animations: {
            self.organicView.addSubview(egg)
            
            egg.center.x -= 150
            egg.center.y -= 90
            
        }, completion: { _ in
            
            UIView.animateKeyframes(withDuration: 2.5, delay: 0.5, options: [], animations: {
                self.organicView.addSubview(bathroom)
                bathroom.center.x += 150
                bathroom.center.y -= 90
                
            }, completion: { _ in
            UIView.animateKeyframes(withDuration: 2.5, delay: 0.5, options: [], animations: {
                    self.organicView.addSubview(banana)
                    banana.center.y += 38
                    banana.center.x -= 150
                    
                }, completion: { _ in
                    UIView.animateKeyframes(withDuration: 2.5, delay: 0.5, options: [], animations: {
                        self.organicView.addSubview(can)
                        can.center.y += 38
                        can.center.x += 150
                        
                    }, completion: { _ in
                        UIView.animateKeyframes(withDuration: 2.5, delay: 0.5, options: [], animations: {
                            self.organicView.addSubview(vegetables)
                            vegetables.center.y += 170
                            vegetables.center.x -= 150
                            
                            
                        }, completion: { _ in
                            
                            UIView.animateKeyframes(withDuration: 2.5, delay: 0.5, options: [], animations: {
                                self.organicView.addSubview(water)
                                water.center.y += 170
                                water.center.x += 150
                                
                            }, completion: { _ in
                                
                                UIView.transition(with:self.organicView, duration: 0.33, options:[.curveEaseIn, .transitionCurlDown] , animations: {
                                    egg.removeFromSuperview()
                                    banana.removeFromSuperview()
                                    vegetables.removeFromSuperview()
                                  
                            
                                }, completion: nil)
                                
                                UIView.transition(with: self.inorganicView, duration: 0.33, options:[.curveEaseIn, .transitionFlipFromBottom] , animations: {
                                    bathroom.removeFromSuperview()
                                 
                                    water.removeFromSuperview()
                                    can.removeFromSuperview()
                                  
                                    
                                    
                                }, completion: { _ in
                        
                                    UIView.transition(with: Intro(), duration: 0.4, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
                                        
                                        let CView = ClassifireView(frame: CGRect(x: 0, y: 0, width: 500, height: 600))
                                        self.addSubview(CView)
                                    }, completion: nil)
                                })
                                
                                
                            })
                        })
                    })
                })
            })
        })

        
    }
    
    
    func hideViews(){
        
    }
    
}
