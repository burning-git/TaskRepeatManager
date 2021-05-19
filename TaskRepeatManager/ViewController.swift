//
//  ViewController.swift
//  TaskRepeatManager
//
//  Created by git burning on 2021/5/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightItem = UIBarButtonItem(title: "Test", style: .done, target: self, action: #selector(testAction))
        self.navigationItem.rightBarButtonItem = rightItem
        
        // Do any additional setup after loading the view.
    }

    @objc private func testAction() {

        let vc = TestViewController()
        self.present(vc, animated: true, completion: nil)
        
    }

}

