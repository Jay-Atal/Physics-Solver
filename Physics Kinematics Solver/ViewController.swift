//
//  ViewController.swift
//  Physics Kinematics Solver
//
//  Created by Jay Atal on 12/20/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var varToSolve: UITextField!
    @IBOutlet weak var varNotGiven: UITextField!
    
    @IBOutlet weak var error: UILabel!
    let options = ["vi", "vf", "a", "t", "d"]
    
    var values: [String: Double] = [:]

    
    
    var toSolvePickerView = UIPickerView()
    var notGivenPickerView = UIPickerView()
    
    @IBOutlet weak var var1Out: UILabel!
    @IBOutlet weak var var3Out: UILabel!
    @IBOutlet weak var var2Out: UILabel!
    
    @IBOutlet weak var var1Text: UITextField!
    @IBOutlet weak var var2Text: UITextField!
    @IBOutlet weak var var3Text: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //height.keyboardType = UIKeyboardType.numberPad
        
        
        varToSolve.inputView = toSolvePickerView
        varNotGiven.inputView = notGivenPickerView
        
        varToSolve.placeholder = "Variable To Solve"
        varNotGiven.placeholder = "Variable Not Given"
        
        error.text=""
        
        varToSolve.textAlignment = .center
        varNotGiven.textAlignment = .center
        
        toSolvePickerView.delegate = self
        toSolvePickerView.dataSource = self
        
        notGivenPickerView.delegate = self
        notGivenPickerView.dataSource = self
        
        toSolvePickerView.tag = 1
        notGivenPickerView.tag = 2
        
       
        
        
    }
    
    func assign()
    {
        if(varToSolve.text == varNotGiven.text)
        {
            error.text="Variable to Solve cannot be same as Variable Not Given"
//            var1Out.removeFromSuperview()
//            var2Out.removeFromSuperview()
//            var3Out.removeFromSuperview()
            return
        }
        else{
//            var1Out.addSubview(<#T##view: UIView##UIView#>)
//            var2Out.addSubview(view)
//            var3Out.addSubview(view)
            error.text = ""
        }
        let options2: NSMutableOrderedSet = ["vi", "vf", "a", "t", "d"]
        
        print(options2)
        if(options2.contains(varToSolve.text!)){
            options2.remove(varToSolve.text!)
            
        }
        
        if(options2.contains(varNotGiven.text!)){
            options2.remove(varNotGiven.text!)
        }
        
        print(options2)
        
        var1Out.text = (options2[0] as! String)
        options2.removeObject(at: 0)
        print(options2)
        
        var2Out.text = (options2[0] as! String)
        options2.removeObject(at: 0)
        print(options2)
        
        var3Out.text = (options2[0] as! String)
        options2.removeObject(at: 0)
        print(options2)
        
//        var2Out.text = options2.first
//        options2.remove(options2.first!)
//
//        print(options2)
//
//        var3Out.text = options2.first
//        options2.remove(options2.first!)
//
        print(options2)
        
        //var2Out.text = options2.remove(at:0)
        //var3Out.text = options2.remove(at:0)
    }
    
    func assignValues()
    {
        var localValues: [String: Double] = [:]
        localValues[var1Out.text!] = Double(var1Text.text!)
        localValues[var2Out.text!] = Double(var2Text.text!)
        localValues[var3Out.text!] = Double(var3Text.text!)
        
        values = localValues
    }
    
    func solve()
    {
        assign()
        assignValues()
        
        if(varNotGiven.text! == "vf")
        {
            if(varToSolve.text == "d")
            {
                let vi = values["vi"]!
                let a  = values["a"]!
                let t = values["t"]!
               
                let answer:Double = vi*t+0.5*a*t*t
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "vi")
            {
                let d = values["d"]!
                let a  = values["a"]!
                let t = values["t"]!
                
                if(t==0)
                {
                    error.text = "T cannot be euqal to 0"
                }
                let answer:Double = (d-0.5*a*t*t)/t
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "a")
            {
                let d = values["d"]!
                let vi  = values["vi"]!
                let t = values["t"]!
                //D = vi*t + 0.5 * a * t *t
                if(t<=0)
                {
                    error.text = "T cannot be euqal to 0"
                }
                let answer:Double = 2*(d-vi*t )/(t*t)
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "t")
            {
                let d = (values["d"]! * -1)
                let vi  = values["vi"]!
                let a = (values["a"]! * 0.5)

                if(a==0)
                {
                    error.text = "a cannot be 0"
                }
                
                if(vi*vi-4*a*d < 0)
                {
                    error.text = "Re Check Inputs"
                
                }
                
                var answer:Double
                if((-vi+sqrt(vi*vi-4*a*d)/(2*a))>=0) {
                    answer = (-vi+sqrt(vi*vi-4*a*d)/(2*a))
                    
                }  else {
                    answer = (-vi-sqrt(vi*vi-4*a*d)/(2*a))
                    
                }
                error.text = "\(answer)"
            }
        }
        
        if(varNotGiven.text! == "t")
        {
            if(varToSolve.text == "vf")
            {
                let vi = values["vi"]!
                let a  = values["a"]!
                let d = values["d"]!
               
                let answer:Double = sqrt(vi*vi+2*a*d)
                error.text = "\(answer) or -\(answer)"
            }
            
            if(varToSolve.text == "vi")
            {
                let vf = values["vf"]!
                let a  = values["a"]!
                let d = values["d"]!
               
                let answer:Double = sqrt(vf*vf-2*a*d)
                error.text = "\(answer) or -\(answer)"
            }
            
            if(varToSolve.text == "a")
            {
                let vf = values["vf"]!
                let vi  = values["vi"]!
                let d = values["d"]!
               
                let answer:Double = (vf*vf-vi*vi)/(2*d)
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "d")
            {
                let vf = values["vf"]!
                let vi  = values["vi"]!
                let a = values["a"]!
               
                let answer:Double = (vf*vf-vi*vi)/(2*a)
                error.text = "\(answer)"
            }
            
        }
        
        if(varNotGiven.text! == "d")
        {
            if(varToSolve.text == "vf")
            {
                let vi = values["vi"]!
                let a  = values["a"]!
                let t = values["t"]!
               
                let answer:Double =  vi + a*t
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "vi")
            {
                let vf = values["vf"]!
                let a  = values["a"]!
                let t = values["t"]!
               
                let answer:Double = vf-a*t
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "a")
            {
                let vf = values["vf"]!
                let vi  = values["vi"]!
                let t = values["t"]!
               
                let answer:Double = (vf-vi)/t
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "t")
            {
                let vf = values["vf"]!
                let vi  = values["vi"]!
                let a = values["a"]!
               
                let answer:Double = (vf-vi)/a
                error.text = "\(answer)"
            }
            
            
        }
        
        if(varNotGiven.text! == "a")
        {
            if(varToSolve.text == "d")
            {
                let vi = values["vi"]!
                let vf  = values["vf"]!
                let t = values["t"]!
               
                let answer:Double =  ((vi+vf)/2)*t
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "vi")
            {
                let d = values["d"]!
                let t  = values["t"]!
                let vf = values["vf"]!
               
                let answer:Double = (2*d/t-vf)
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "vf")
            {
                let d = values["d"]!
                let t  = values["t"]!
                let vi = values["vi"]!
               
                let answer:Double = (2*d/t-vi)
                error.text = "\(answer)"
            }
            
            if(varToSolve.text == "t")
            {
                let d = values["d"]!
                let vi  = values["vi"]!
                let vf = values["vf"]!
               
                let answer:Double = (2*d)/(vi+vf)
                error.text = "\(answer)"
            }
            
            
        }
        
        
        
            
    }
    
    @IBAction func done(_ sender: Any) {
        assign()
    }
    
    @IBAction func solve(_ sender: Any) {
        assign()
        solve()
    }
}



extension ViewController: UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 1:
            varToSolve.text = options[row]
            varToSolve.resignFirstResponder()
            
        case 2:
            varNotGiven.text = options[row]
            varNotGiven.resignFirstResponder()
            
            default:
                return
        }
        
        }
   
    }

