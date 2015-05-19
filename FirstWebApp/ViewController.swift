//
//  ViewController.swift
//  FirstWebApp
//
//  Created by chintan on 5/11/15.
//  Copyright (c) 2015 chintan. All rights reserved.
//

import UIKit
import WebKit
import CoreBluetooth

class ViewController: UIViewController, WKScriptMessageHandler, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @IBOutlet var containerView : UIView! = nil

    
    var webView: WKWebView?
    
    var CentralManager : CBCentralManager!
    var Peripheral : CBPeripheral!
    
    let GUUID = CBUUID(string: "F000AA00-0451-4000-B000-000000000000")
    
    //let url = "http://www.google.com"
    let url = NSBundle.mainBundle().URLForResource("index", withExtension:"html")
    
    override func loadView(){
        super.loadView()
        
        var contentController = WKUserContentController();
        
        //this is an example of injecting javascript from swift, this is changing the color of header to red.
        var userScript = WKUserScript(
            source: "redHeader()",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        
        
        //listener for receiving msgs from javascript
        contentController.addScriptMessageHandler(
            self,
            name: "callbackHandler"
        )
        
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame: self.containerView.bounds,
            configuration: config
        )
        self.view = self.webView!
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CentralManager = CBCentralManager(delegate: self, queue: nil)
        var req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
        
        
    }
    

    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            println("JavaScript is sending a message \(message.body)")
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        if central.state == CBCentralManagerState.PoweredOn {
            central.scanForPeripheralsWithServices(nil, options: nil)
            println("Scanning for peripherals")
        } else {
            println("Bluetooth switched off or not initialized")
        }
    }


}

