import Foundation
import UIKit

open class ClassifireView: UIView {
 
    var textField = UITextField()
    let  classifier = NaiveBayesClassifier()
    
    let title = UILabel(frame: CGRect(x: 60, y: 20, width: 400, height: 150))
    let question = UILabel(frame: CGRect(x: 60, y: 90, width: 400, height: 150))
    let popInorganic = UIView(frame: CGRect(x: 0, y: 0, width: 360, height: 300))
    let popOrganic = UIView(frame: CGRect(x: 0, y: 0, width: 360, height: 300))
    let message = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
    let message2 =  UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red:64.0/255.0, green:80.0/255.0 ,blue:89.0/255.0 , alpha:1.0)
          textField =  createTextField()
        

        title.text = "Organic or Inorganic"
        question.text = "Mention an object that you throw trash the most?"
        
        title.font = UIFont(name: "Helvetica", size: 30)
        title.textColor = UIColor.white
        title.textAlignment = NSTextAlignment.center
        
        
        question.textColor = UIColor.white
        question.numberOfLines = 2
        question.textAlignment = NSTextAlignment.center
        question.font = UIFont(name: "Helvetica", size: 16)
        
        let btn: UIButton = UIButton(frame: CGRect(x: 170, y: 300, width: 180, height: 40))
        btn.backgroundColor =  UIColor(red:115.0/255.0, green:176.0/255.0 ,blue:111.0/255.0 , alpha:1.0)
        btn.layer.cornerRadius = 10
        btn.setTitle("Classify", for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
        addSubview(question)
        addSubview(title)
        addSubview(textField)
        addSubview(btn)
        
        
       
        

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    
    func ReadTrainingInorganic() throws->  String {
        
        guard let FileUrl  = Bundle.main.url(forResource: "TrainingDataSet", withExtension: "txt") else {
            throw NSError(domain: "Opcional Vacio", code: 0, userInfo: nil)
        }
        let data = try String(contentsOf: FileUrl, encoding: .utf8)
        let myStrings = data.components(separatedBy: .newlines)
        let trainingDataSetInorganic = myStrings.joined(separator: ", ")
        return trainingDataSetInorganic

        
    }
    
    func ReadTrainingOrganic() throws->  String {
        
        
        guard let FileUrl2  = Bundle.main.url(forResource: "TrainingDataSetOrg", withExtension: "txt") else {
            throw NSError(domain: "Opcional Vacio", code: 0, userInfo: nil)
        }
        let data2 = try String(contentsOf: FileUrl2, encoding: .utf8)
        let myStrings2 = data2.components(separatedBy: .newlines)
        let trainingDataSetOrg = myStrings2.joined(separator: ", ")

        return trainingDataSetOrg
        
        
    }
    
 
    func btnAction(){
        
        let textTrainingInorganic = try! ReadTrainingInorganic()
        classifier.trainWithText(textTrainingInorganic, category:"Inorganic")
        
        let textTrainingOrganic = try! ReadTrainingOrganic()
        classifier.trainWithText(textTrainingOrganic, category:"Organic")
        if let tex = textField.text{
            let newText = tex.lowercased()
            let result = classifier.classify(newText)
            
            if  result == " " {
                
            }else {
                
                if  result == "Organic"{
                    //print("Mensaje organico ")
                    createMessageOrganic()
                } else {
                    createMessageInorganic()
                    //print("Mensaje inorganico Inorganic")
                }
                
            }
          
        }
        
     
    }
    
    
    func createMessageOrganic(){
        
        var arrayMessage:[String] = []
        arrayMessage.append("One person throws 50 kg of containers a year")
        arrayMessage.append("The red worm transforms the organic waste into humus.⁠⁠⁠⁠")
        arrayMessage.append("Serves as fertilizer for the land or gardens.")
     
        self.popOrganic.backgroundColor =  UIColor(red:115.0/255.0, green:176.0/255.0 ,blue:111.0/255.0 , alpha:1.0)
         //message2 =  UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150)
        message2.numberOfLines = 5
        message2.textAlignment = .center
        message2.center = self.popOrganic.center
        message2.center.x = self.popOrganic.center.x
        message2.center.y = self.popOrganic.center.y
        message2.textColor = UIColor.white
        message2.font = UIFont(name: "Helvetica", size: 14)
        let randomIndex  = Int(arc4random_uniform(UInt32(arrayMessage.count)))
        message2.text = arrayMessage[randomIndex]
        self.popOrganic.layer.cornerRadius = 10
        self.popOrganic.center = self.center
        self.popOrganic.center.x = self.center.x
        self.popOrganic.center.y = self.center.y
        
        // set the timer
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.dismissAlert2), userInfo: nil, repeats: false)
        
            addSubview(self.popOrganic)
            self.popOrganic.addSubview(self.message2)
        
            
      
        
 
    }
    
    func createMessageInorganic(){
        var arrayMessage:[String] = []
         arrayMessage.append("Did you know that actually throwing inorganic products are throwing natural resources since these are mostly made of non-renewable resources")
        arrayMessage.append("When we recycle a container or product, we are avoiding that they are stored in large landfills, some of them out of control and oversaturated")
        arrayMessage.append("The use of recyclable materials as raw material in the manufacture of new products helps to conserve renewable and non-renewable natural resources.")
        
        let randomIndex  = Int(arc4random_uniform(UInt32(arrayMessage.count)))

        self.popInorganic.backgroundColor = UIColor(red:95.0/255.0, green:128.0/255.0 ,blue:135.0/255.0 , alpha:1.0)
        
        message.numberOfLines = 5
        message.textAlignment = .center
        message.center = self.popInorganic.center
        message.center.x = self.popInorganic.center.x
        message.center.y = self.popInorganic.center.y
        message.textColor = UIColor.white
        message.text =  arrayMessage[randomIndex]
        message.font = UIFont(name: "Helvetica", size: 14)
        
        self.popInorganic.layer.cornerRadius = 10
        self.popInorganic.center = self.center
        self.popInorganic.center.x = self.center.x
        self.popInorganic.center.y = self.center.y
        
        
        // set the timer
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.dismissAlert), userInfo: nil, repeats: false)
        
        
        
            addSubview(self.popInorganic)
            self.popInorganic.addSubview(self.message)
        
     
       
    }
    
    func dismissAlert(){
        
            self.popInorganic.removeFromSuperview()
            self.message.removeFromSuperview()
            
       
        
    }
    
    func dismissAlert2(){
            self.popOrganic.removeFromSuperview()
            self.message2.removeFromSuperview()
            
       
    }
    
    
    
    
   open  func createTextField() -> UITextField {
        
        let textField = UITextField(frame: CGRect(x: 110 , y: 210, width: 320, height: 40))
          textField.borderStyle = UITextBorderStyle.roundedRect
           textField.clearsOnBeginEditing = true
    
        return textField
    }
    
    

}

