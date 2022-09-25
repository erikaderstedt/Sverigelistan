//
//  ViewController.swift
//  Sverigelistan
//
//  Created by Erik Aderstedt on 2022-09-25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tidFrånFält(fält: UITextField) -> Int? {
        guard let text = fält.text else {
            return nil
        }
        
        let delar = text.components(separatedBy: ":")
        
        switch delar.count {
        case 2:
            guard let minuter = Int(delar[0]), let sekunder = Int(delar[1]) else {
                return nil
            }
            return minuter*60 + sekunder
        case 3:
            guard let timmar = Int(delar[0]), let minuter = Int(delar[1]), let sekunder = Int(delar[2]) else {
                return nil
            }
            return timmar*3600 + minuter*60 + sekunder
        default:
            return nil
        }
    }
    
    func poängFrånFält(fält: UITextField) -> Double? {
        guard let text = fält.text else {
            return nil
        }
        
        return Double(text.replacingOccurrences(of: ",", with: "."))
    }

    @IBOutlet var fältFörPoäng1: UITextField! = nil
    @IBOutlet var fältFörPoäng2: UITextField! = nil
    @IBOutlet var fältFörPoäng3: UITextField! = nil

    @IBOutlet var fältFörTid1: UITextField! = nil
    @IBOutlet var fältFörTid2: UITextField! = nil
    @IBOutlet var fältFörTid3: UITextField! = nil

    @IBOutlet var fältFörMinTid: UITextField! = nil
    
    @IBOutlet var fältFörTillägg: UITextField! = nil

    @IBOutlet var resultat: UILabel! = nil
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if    let poäng1 = poängFrånFält(fält: fältFörPoäng1),
              let poäng2 = poängFrånFält(fält: fältFörPoäng2),
              let poäng3 = poängFrånFält(fält: fältFörPoäng3),
              let tid1 = tidFrånFält(fält: fältFörTid1),
              let tid2 = tidFrånFält(fält: fältFörTid2),
              let tid3 = tidFrånFält(fält: fältFörTid3),
              let tillägg = poängFrånFält(fält: fältFörTillägg),
              let minTid = tidFrånFält(fält: fältFörMinTid) {
            
            let segrartiden = min(tid1,tid2,tid3)
            let Tm = min(Double(segrartiden)*1.1, Double((tid1 + tid2 + tid3) / 3))
            let Pm = (poäng1 + poäng2 + poäng3) / 3 - tillägg
            let poängPåDenna = (Double(minTid) - (Tm - Pm/((75.0 + Pm)/Tm))) * ((75.0 + Pm)/Tm)
            
            resultat.text = String(format: "%.2f", poängPåDenna + tillägg).replacingOccurrences(of: ".", with: ",")
        } else {
            resultat.text = "?"
        }
    }
}

