//
//  ViewController.swift
//  Tenis
//
//  Created by Edi Stern on 4/6/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SCLAlertView

class ViewController: UIViewController {
    @IBOutlet weak var txtUser : UITextField!;
    @IBOutlet weak var txtPasswd : UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUser.text = UserDefaults.standard.value(forKey: "txtUser") as? String
        txtPasswd.text = UserDefaults.standard.value(forKey: "txtPasswd") as? String
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // se apeleaza login
    @IBAction func login ()
    {
        SVProgressHUD.show();
        let url = URL(string: "http://graphichouse.ro/adrian/useri.php?mail=\(String(describing: txtUser.text!))&parola=\(txtPasswd.text!)")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                self.retrieveJsonFromData(data!);
            }
        }).resume()
    }
    
    // se parseaza json
    func retrieveJsonFromData(_ data: Data){
        /* Now try to deserialize the JSON object into a dictionary */
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary,
                let blogs = json["useri"] as? [[String: Any]] {
                for blog in blogs {
                    let jucator = User();
                    if let name = blog["nume"] as? String {
                        jucator.nume = name;
                    }
                    if let greutate = blog["greutate"] as? Int {
                        jucator.greutate = greutate;
                    }
                    if let inaltime = blog["inaltime"] as? Int {
                        jucator.inaltime = inaltime;
                    }
                    if let id_user = blog["id_user"] as? Int {
                        jucator.id_user = id_user;
                    }
                    if let sex = blog["sex"] as? Int {
                        jucator.sex = sex;
                    }
                    if let judet = blog["judet"] as? String {
                        jucator.judet = judet;
                    }
                    if let nivel = blog["nivel"] as? Int {
                        jucator.nivel = nivel;
                    }
                    if let telefon = blog["telefon"] as? String {
                        jucator.telefon = telefon;
                    }
                    if let punctaj = blog["punctaj"] as? Int {
                        jucator.punctaj = punctaj;
                    }
                    if let localitate = blog["localitate"] as? String {
                        jucator.localitate = localitate;
                    }
                    if let mana_de_joc = blog["mana_de_joc"] as? Int {
                        jucator.mana_de_joc = mana_de_joc;
                    }
                    if let prenume = blog["prenume"] as? String {
                        jucator.prenume = prenume;
                    }
                    if let rever = blog["rever"] as? Int {
                        jucator.rever = rever;
                    }
                    if let data_inscriere_in_circuit = blog["data_inscriere_in_circuit"] as? String {
                        jucator.data_inscriere_in_circuit = data_inscriere_in_circuit;
                    }
                    
                    Utils.userCurent = jucator;
                    break;
                }
                if (blogs.count != 0){
                    DispatchQueue.main.async(){
                        //write your code
                        UserDefaults.standard.setValue(self.txtUser.text!, forKey: "txtUser")
                        UserDefaults.standard.setValue(self.txtPasswd.text!, forKey: "txtPasswd")
                        self.performSegue(withIdentifier: "segue_next_login", sender: self)
                    }
                    
                }else {
                    DispatchQueue.main.async(){
                        //write your code
                        SCLAlertView().showError("Eroare", subTitle: "Adresa de email sau parola sunt gresite");
                    }
                    
                }
                SVProgressHUD.dismiss();
            }
            
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        
    }
    
    
}

