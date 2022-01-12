//
//  ViewController.swift
//  UpDownGame
//
//  Created by 이민호 on 2022/01/06.
//

import UIKit

class ViewController: UIViewController {
    
    let failAlert = UIAlertController(title: "실패", message: "5번의 기회를 모두 실패하였습니다.", preferredStyle: .alert)
    let successAlert = UIAlertController(title: "성공", message: "성공하셨습니다!", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default )
    var randomValue: Int = 0
    var tryCount: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reset()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        let integerValue: Int = Int(sender.value)
        sliderValueLabel.text = String(integerValue)
        // 왜 sliderValueLabel.text = String(Int(integerValue)) 이렇게 안하는 거지?
        // integerValue는 sender.value가 변할때 마다 선언을 해주니까 let이 오는구나!
        
    }
    
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        print(slider.value)
        let hitValue: Int = Int(slider.value)
        slider.value = Float(hitValue)
        //slider.value를 다시 지정해 주는 이유는 hitButton을 눌렀을때 print에 찍히는 정확한 소수점까지 일치하게 하기 위해서다.
        //그래서 hitButton을 누르면 미세하게 slider가 소숫점 정확한 위치까지 움직이는 것을 알 수 있다.
        //slider.value를 다시 지정하지 않으면 정수범위만 슬라이더가 반응한다.
        tryCount = tryCount + 1
        tryCountLabel.text = "\(tryCount) / 5" // -> String(tryCount) + " / 5"
        
        if randomValue == hitValue {
            showAlert(message: "YOU HIT!!!!")
            //print("YOU HIT!!!!")
            reset()
            //return // 맞추면 return으로 함수를 종료해야 한다.
                 // 5번째에 맞추면 YOU HIT 과 YOU LOSE가 동시에 출력되기 때문이다.
                 // else if 구문으로 작성하면 return이 필요없다.
        }else if tryCount >= 5 {
            showAlert(message: "YOU LOSE")
            //print("YOU LOSE")
            reset()
            //return
        }else if randomValue > hitValue {
            slider.minimumValue = Float(hitValue)
            minimumValueLabel.text = String(hitValue)
        } else if randomValue < hitValue {
            slider.maximumValue = Float(hitValue)
            maximumValueLabel.text = String(hitValue)
        }
        // slider.minimumValue의 값은 Int이다. hitValue의 값도 Int로 정했다. 그러나 컴퓨터는 hitValue의 값을 Float으로 인식한다. 왜그럴까?
        // slider.minimumValue가 Float이다. slider의 value값은 Float이기 때문이다. 즉 초기값은 0.0인 셈이다. 그러므로 hitValue를 Float으로 바꾸어 주어야 한다.
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in self.reset() }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        print("touch up reset button")
        reset()
    }
    
    func reset() {
        print("reset!")
        randomValue = Int.random(in: 0...30)
        print(randomValue)
        tryCount = 0
        tryCountLabel.text = "0 / 5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
    }
    
    
//    func tryHit() {
//        if(tryCount == randomValue){
//
//        }else {
//            if(tryCount < 5){
//                tryCount = tryCount + 1
//                tryCountLabel.text = "\(tryCount) / 5" // -> String(tryCount) + " / 5"
//            }else{
//
//            }
//
//        }
//    }
}

