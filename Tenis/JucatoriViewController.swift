//
//  JucatoriViewController.swift
//  Tenis
//
//  Created by Edi Stern on 6/22/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class JucatoriViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var segmentControl : UISegmentedControl!;
    var jucatori : [User] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        getPlayersByLevel(nivel: 4);
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // se iau informatiile de pe server
    
    func getPlayersByLevel (nivel : Int){
        SVProgressHUD.show();
        
        jucatori.removeAll();
        let url = URL(string: "http://graphichouse.ro/adrian/useri.php?nivel=\(nivel)")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                self.retrieveJsonFromData(data!);
            }
        }).resume()
    }
    
    // se parseaza json-ul
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
                    jucatori.append(jucator);
                }
                let when = DispatchTime.now() + 0.1
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.tableView.reloadData();
                    SVProgressHUD.dismiss();
                }

            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jucatori.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ProfileViewController.user = jucatori[indexPath.row];
        self.performSegue(withIdentifier: "goToProfile2", sender: self)

    }
    
    // se creaza tabelul
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayerTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as! PlayerTableViewCell
        cell.lblNume.text = "\(jucatori[indexPath.row].nume.capitalized) \(jucatori[indexPath.row].prenume.capitalized)"
        cell.lblIndex.text = "\(indexPath.row + 1)"
        cell.lblPunctaj.text = "\(jucatori[indexPath.row].punctaj)"
        cell.lblNume.adjustsFontSizeToFitWidth = true;
        return cell;
    }
    
    // control pentru segmentcontrol
    @IBAction func indexChanged(sender:UISegmentedControl)
    {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            getPlayersByLevel(nivel: 4);
        case 1:
            getPlayersByLevel(nivel: 5);
        case 2:
            getPlayersByLevel(nivel: 6);
        case 3:
            getPlayersByLevel(nivel: 7);
        case 4:
            getPlayersByLevel(nivel: 8);
        case 5:
            getPlayersByLevel(nivel: 9);
        default:
            break;
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
