//
//  ViewController.swift
//  ASProgress
//
//  Created by amitpstu1@gmail.com on 07/20/2020.
//  Copyright (c) 2020 amitpstu1@gmail.com. All rights reserved.
//

import UIKit
import ASProgress

class ViewController: UIViewController {
    @IBOutlet weak var progressParents: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSpinner(_ sender: Any) {
        ASProgress.show(progressParents)
        self.perform(#selector(dismissSpinner(_:)), with: nil, afterDelay: 5.0)
    }
    
    @IBAction func showSpinnerIntoSelf(_ sender: Any) {
        ASProgress.show()
        self.perform(#selector(dismissSpinner(_:)), with: nil, afterDelay: 5.0)
    }
    
    @objc func dismissSpinner(_ sender: Any) {
        ASProgress.dismiss()
    }
}

