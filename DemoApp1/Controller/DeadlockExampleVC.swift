//
//  DeadlockExampleVC.swift
//  DemoApp1
//
//  Created by Pramod Kumar Pranav on 06/09/19.
//  Copyright © 2019 Pramod Kumar Pranav. All rights reserved.
//

import UIKit

class DeadlockExampleVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
       // deadLockByMainQueue()
        deadLockByCustomQueue()
    }
    
    
    func deadLockByMainQueue() {
        // sync method can not be called on main thread, because it will block the thread completely and lead the application to deadlock
        let mainQueue = DispatchQueue.main
        mainQueue.sync { // -> This code will lead to Deadlock
            print("Inner block called")
            self.someTask()
        }
    }
    
    func deadLockByCustomQueue() {
//        It is clear that the inner and the outer blocks are executing on the same queue. By default, a custom queue is serial so the inner block will not start before the outer block finishes. On the other hand, the outer block can not finish because the inner block is holding the control of the current thread (Synchronously). Hence, a deadlock occurs.
        let customQueue = DispatchQueue(label: "customQueue")
        customQueue.async {
            customQueue.sync {
                print("Inner block called")
                self.someTask()
            }
            print("Outer block called")
        }
    }
    func someTask() {
        print("Some task")
    }
}
