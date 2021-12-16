//
//  ViewController.swift
//  calculator
//

//  Created by Shubham on 12/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder : UIView!
    var firstNumber = 0
    var resultNumber = 0
    var currentOperation : operation?                       // why ques mark at end of operation
    
    enum operation {
        case add , subtract , multiply , divide
    }
    
    private var resultlabel : UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Arial", size: 24)
        return label                                        // how can we return in a variable. and no
                                                            //return type is defined
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNumberPad()
        
    }

    private func setupNumberPad(){
        let buttonSize : CGFloat = view.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize * 3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)

        holder.addSubview(zeroButton)

        
        for x in 0..<3{
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x+1)", for: .normal)
            button1.tag = x + 2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button1)
        }
        
        for x in 0..<3{
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x+4)", for: .normal)
            button2.tag = x + 5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)


            holder.addSubview(button2)
        }
        
        for x in 0..<3{
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.setTitle("\(x+7)", for: .normal)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button3)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize*5) , width: buttonSize * 3, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitle("clear", for: .normal)
       clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)


        holder.addSubview(clearButton)
        
        
        let opr = ["=","+","-","*","/"]
        
        for x in 0..<5{
            let button4 = UIButton(frame: CGRect(x: buttonSize*3, y: holder.frame.size.height - (buttonSize*CGFloat(x+1)), width: buttonSize, height: buttonSize))
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .orange
            button4.setTitle(opr[x], for: .normal)
            holder.addSubview(button4)
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            button4.tag = x+1
        }
        
        resultlabel = UILabel(frame: CGRect(x: 0, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width, height: 100))
        resultlabel.text = "0"
        resultlabel.textColor = .white
        resultlabel.textAlignment = .right
        resultlabel.font = UIFont(name: "Helvetica", size: 100)
        
        holder.addSubview(resultlabel)


}
    
    @objc  func clearResult(){                           // what is the use of @objc here?
        resultlabel.text = "0"
        currentOperation = nil
        firstNumber = 0
    }
    
    @objc func numberPressed(_ sender:UIButton){
        let tag = sender.tag - 1
        if resultlabel.text == "0"{
            resultlabel.text = "\(tag)"
        }
        else if let text = resultlabel.text{
            resultlabel.text = "\(text)\(tag)"
        }

    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        
        // why firstnumber = 0 in the following condition
        if let text = resultlabel.text , let value = Int(text), firstNumber == 0{
            firstNumber = value
            resultlabel.text = "0"
        }
        if tag == 1{
            if let operation = currentOperation{
                var secondNumber = 0
                if let text = resultlabel.text , let value = Int(text){
                    secondNumber = value
                }
                
                switch operation{
                case .add:
                   let result =  firstNumber + secondNumber
                    resultlabel.text = "\(result)"
                    break
                case .subtract:
                  let result =  firstNumber - secondNumber
                    resultlabel.text = "\(result)"
                    break
                case .multiply:
                   let result = firstNumber * secondNumber
                    resultlabel.text = "\(result)"
                    break
                case .divide:
                   let result = firstNumber / secondNumber
                    resultlabel.text = "\(result)"
                    break
                }
                
            }
        }
        else if tag == 2{
            currentOperation = .add
        }
        else if tag == 3{
            currentOperation = .subtract
        }
        else if tag == 4{
            currentOperation = .multiply
        }
        else if tag == 5{
            currentOperation = .divide
        }

    }

}





// why do we have to use holder.addsubview for every button. like if we are creating a button it would obv present in the view only
