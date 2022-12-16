//
//  ViewController.swift
//  QRScanner
//
//  Created by Ye Yint Aung on 09/12/2022.
//

import UIKit
import Pods_QRScanner
import MercariQRScanner
import AVFoundation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpQRScanner()
        
    }
    
    private func setUpQRScanner(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            setUpQRScannerView()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        [weak self] in
                        self?.setUpQRScannerView()
                    }
                }
            }
        default:
            showAlert()
        }
    }
    
    private func setUpQRScannerView(){
        let qrScannerView = QRScannerView(frame: view.bounds)
        view.addSubview(qrScannerView)
        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        qrScannerView.startRunning()
    }
    
    private func showAlert(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
            let alert = UIAlertController(title: "Error", message: "Access Camera", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }

}

extension ViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error.localizedDescription)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
        
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            
            let alert = UIAlertController(title: "Success", message: code, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { action in
                UIPasteboard.general.string = code
            }))
            alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { action in
                UIApplication.shared.open(URL(string: code)!)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}

