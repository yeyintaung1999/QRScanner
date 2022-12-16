//
//  ResultViewController.swift
//  QRScanner
//
//  Created by Ye Yint Aung on 11/12/2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel : UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func copyButton(_ sender: Any) {
        UIPasteboard.general.string = resultLabel?.text
    }
    
    @IBAction func openButton(_ sender: Any) {
        let url = URL(string: resultLabel?.text ?? "www.google.com")!
        UIApplication.shared.open(url)
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
