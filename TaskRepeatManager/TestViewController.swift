//
//  TestViewController.swift
//  TaskRepeatManager
//
//  Created by git burning on 2021/5/19.
//

import UIKit

class TestViewController: UIViewController {

    lazy var doRepeatModel = BRTaskRepeatManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.doRepeatModel.doRepeatAsyncAction(repeatCount: 10) { index in
            return 1
        } doNextBlock: { (index, errorCallBack) in
            print(index)
            TestViewController.doAfterBlock(block: {
                errorCallBack?()
            })
        }

//
//        BRTaskRepeatManager.doRepeatAsyncAction(targetVC: self, repeatCount: 10)  { index in
//            print("delayBlock:\(index)")
//            // 可以做定制化，比如 间隔时间，越来越越大
//            return 1
//        } doNextBlock: { (index, errorCallBack) in
//            print(index)
//            TestViewController.doAfterBlock(block: {
//                errorCallBack?()
//            })
//        }

        // Do any additional setup after loading the view.
    }
    
    class func doAfterBlock(block:(()->())?) {
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             block?()
         }
     }

     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         super.touchesEnded(touches, with: event)
         self.dismiss(animated: true, completion: nil)
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
