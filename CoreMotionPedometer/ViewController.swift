

import UIKit
// 걸음 수 측정을 위한 프레임워크
import CoreMotion

class ViewController: UIViewController {
    // 거리와 속도를 가져오기 위한 클래스 생성
    var pedometerData = CMPedometerData()
    // 만보기 확인을 위한 CMPedometer()
    let pedometer = CMPedometer()
    let goGreen = UIColor(red: 0, green: 1.0, blue: 0.15, alpha: 1.0)
    let stopRed = UIColor(red: 1.0, green: 0, blue: 0.15, alpha: 1.0)
    
    var distance = 0.0
    var pace = 0.0
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var startStopPedometer: UIButton!
    // 토글기능 추가
    @IBAction func startStopPedometer(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start" {
            statusLabel.text = "Pedometer On"
            sender.setTitle("Stop", for: .normal)
            sender.backgroundColor = stopRed
            // CMPedometer 카운팅 가능한 경우
            if CMPedometer.isStepCountingAvailable() {
                // 오늘 날짜 기준 업데이트 시작
                pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
                    if let pedometerData = pedometerData {
                        //
//                        self.pedometerData = pedometerData.currentPace
                        print(pedometerData)
                        DispatchQueue.main.async {
                            self.stepLabel.text = "Steps: \(pedometerData.numberOfSteps)"
                            debugPrint("\(Date()) -- \(pedometerData.numberOfSteps)")
                        }
                    }
                })
            } else {
                // pedometer 업데이트 멈춤
                pedometer.stopUpdates()
                print("Step Counter is not available")
            }
            
        } else {
            statusLabel.text = "Pedometer Off"
            sender.backgroundColor = goGreen
            sender.setTitle("Start", for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopPedometer.backgroundColor = goGreen
        stepLabel.text = "Steps: Not Avaiable"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

