//
//  ViewController.swift
//  NFCApp
//
//  Created by Richard Adem on 14/6/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

import UIKit
import CoreNFC


class ViewController: UIViewController {
    
    var session: NFCNDEFReaderSession!
    
    let startScanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start scanning NFC", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(startScanButton)
        startScanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startScanButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startScanButton.addTarget(self, action: #selector(startScanButtonTapped), for: .touchUpInside)
    }
    
    @objc func startScanButtonTapped(sender: UIButton) {
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session.begin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    print(string)
                }
            }
        }
    }
    
    
}

