//
//  ViewController.swift
//  RagingBeaconTest
//
//  Created by Pawel Trojan on 10.07.2017.
//  Copyright © 2017 Pawel Trojan. All rights reserved.
//

import UIKit
import CoreLocation

enum RagingState {
    case start
    case stop
}

class BeaconRagingViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var signalStrengthLabel: UILabel!
    @IBOutlet weak var startRagingButton: UIButton!
    @IBOutlet weak var stopRagingButton: UIButton!
    
    private var coreLocationManager: CLLocationManager?
    private var region: CLBeaconRegion!
    private final let sampleUUID = "3B2DCB64-A300-4F62-8A11-F6E7A06E4BC0"
    private var ragingState: RagingState = .stop
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.setUpBeaconRaging()
    }
    
    private func setUpViews() {
        switch self.ragingState {
        case .stop:
            
        case .start:
        }
    }
    
    private func setUpBeaconRaging() {
        self.region = CLBeaconRegion(proximityUUID: UUID(uuidString: self.sampleUUID)!, identifier: "com.ptrojan.IphoneHowBeaconBluetooth")
        self.coreLocationManager = CLLocationManager()
        self.coreLocationManager?.requestAlwaysAuthorization()
        self.coreLocationManager?.delegate = self
        self.coreLocationManager?.startMonitoring(for: self.region)
    }
    
    @IBAction func startRagingClickedBtn(_ sender: UIButton) {
        self.region.notifyEntryStateOnDisplay = true
        self.coreLocationManager?.startMonitoring(for: self.region)
        self.coreLocationManager?.startRangingBeacons(in: self.region)
    }

    @IBAction func stopRagingClickedBtn(_ sender: UIButton) {
        self.coreLocationManager?.stopRangingBeacons(in: self.region)
    }
}

//MARK: CLLocationManagerDelegate
extension BeaconRagingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard let beacon = beacons.first else { return }
        
        self.statusLabel.textColor = UIColor.white
        self.signalStrengthLabel.textColor = UIColor.white
        self.signalStrengthLabel.text = "\(beacon.rssi)db"
        
        switch beacon.proximity {
            case .far:
                self.statusLabel.text = "far"
                self.view.backgroundColor = UIColor.blue
            case .immediate:
                self.statusLabel.text = "immediate"
                self.view.backgroundColor = UIColor.purple
            case .near:
                self.statusLabel.text = "near"
                self.view.backgroundColor = UIColor.red
            case .unknown:
                self.statusLabel.text = "unknown"
                self.view.backgroundColor = UIColor.yellow

        }
    }
}
