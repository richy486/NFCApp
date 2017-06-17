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
    
    let textBox: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(textBox)
        textBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textBox.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textBox.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textBox.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        self.view.addSubview(startScanButton)
        startScanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startScanButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
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
    
    func printConsole(_ str: String) {
        if textBox.text.count > 0 {
            textBox.text.append("\n")
        }
        textBox.text.append(str)
        
        
        textBox.scrollRectToVisible(CGRect(x: 0, y: textBox.contentSize.height-1, width: textBox.contentSize.width, height: 1), animated: true)
    }

}

extension ViewController: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        printConsole(error.localizedDescription)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    printConsole(string)
                }
            }
        }
    }
    
    
}

