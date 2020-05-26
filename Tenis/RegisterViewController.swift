//
//  RegisterViewController.swift
//  Tenis
//
//  Created by Edi Stern on 4/7/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit
import XLForm
import SCLAlertView
import Alamofire

class RegisterViewController: XLFormViewController {
    fileprivate struct Tags {
        static let Nume = "Nume"
        static let Prenume = "Prenume"
        static let Email = "Email"
        static let Parola = "Email"
        static let RParola = "Repeta Parola"
        static let Telefon = "Telefon"
        static let Inaltime = "Inaltime"
        static let Greutate = "Greutate"
        static let DataNastere = "Data Nastere"
        static let ManaFolosita = "Mana de baza"
        static let Rever = "Rever"
        let form : XLFormDescriptor
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initializeForm()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeForm()
    }
    
    func initializeForm() {
        // creezi formularu pentru adaugare date
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "Register")
        //form.assignFirstResponderOnShow = true
        
        section = XLFormSectionDescriptor.formSection(withTitle: "Informatii personale")
        section.footerTitle = ""
        form.addFormSection(section)
        
        
        // Name
        row = XLFormRowDescriptor(tag: Tags.Nume, rowType: XLFormRowDescriptorTypeText, title: "Nume")
        row.tag = "nume"
        row.isRequired = true
        section.addFormRow(row)
        
        // Surame
        row = XLFormRowDescriptor(tag: Tags.Prenume, rowType: XLFormRowDescriptorTypeText, title: "Prenume")
        row.tag = "prenume"
        row.isRequired = true
        section.addFormRow(row)
        
        // Judet
        row = XLFormRowDescriptor(tag: Tags.Prenume, rowType: XLFormRowDescriptorTypeText, title: "Judet")
        row.tag = "judet"
        row.isRequired = true
        section.addFormRow(row)
        
        // Localitate
        row = XLFormRowDescriptor(tag: Tags.Prenume, rowType: XLFormRowDescriptorTypeText, title: "Localitate")
        row.tag = "localitate"
        row.isRequired = true
        section.addFormRow(row)
        
        // Email
        row = XLFormRowDescriptor(tag: Tags.Email, rowType: XLFormRowDescriptorTypeEmail, title: "Email")
        row.tag = "email"
        // validate the email
        row.addValidator(XLFormValidator.email())
        row.isRequired = true;
        section.addFormRow(row)
        
        // Parola
        row = XLFormRowDescriptor(tag: Tags.Parola, rowType: XLFormRowDescriptorTypePassword, title: "Parola")
        // validate the email
        row.tag = "parola1"
        row.isRequired = true;
        section.addFormRow(row)
        
        // Email
        row = XLFormRowDescriptor(tag: Tags.RParola, rowType: XLFormRowDescriptorTypePassword, title: "Repeta Parola")
        row.tag = "parola2"
        // validate the email
        row.isRequired = true;
        section.addFormRow(row)
        
        // Telefon
        row = XLFormRowDescriptor(tag: Tags.Telefon, rowType: XLFormRowDescriptorTypeNumber, title: "Telefon")
        row.tag = "telefon"
        section.addFormRow(row)
        
        // Inaltime
        row = XLFormRowDescriptor(tag: Tags.Inaltime, rowType: XLFormRowDescriptorTypeZipCode, title: "Inaltime")
        row.tag = "inaltime"
        section.addFormRow(row)
        
        // Greutate
        row = XLFormRowDescriptor(tag: Tags.Greutate, rowType: XLFormRowDescriptorTypeDecimal, title: "Greutate")
        row.tag = "greutate"
        section.addFormRow(row)
        
        // datanastere
        row = XLFormRowDescriptor(tag: Tags.DataNastere, rowType: XLFormRowDescriptorTypeDate, title: "Data Nastere")
        row.tag = "datanastere"
        section.addFormRow(row)
        
        // sex
        row = XLFormRowDescriptor(tag :Tags.ManaFolosita, rowType:XLFormRowDescriptorTypeSelectorActionSheet, title:"Sex")
        row.selectorOptions = ["Masculin", "Feminin"]
        row.value = "Masculin"
        row.tag = "sex"
        section.addFormRow(row)
        
        
        // mana de baza
        row = XLFormRowDescriptor(tag :Tags.ManaFolosita, rowType:XLFormRowDescriptorTypeSelectorActionSheet, title:"Mana de baza")
        row.selectorOptions = ["Stanga", "Dreapta"]
        row.value = "Dreapta"
        row.tag = "mana"
        section.addFormRow(row)
        
        // rever
        row = XLFormRowDescriptor(tag :Tags.ManaFolosita, rowType:XLFormRowDescriptorTypeSelectorActionSheet, title:"Rever")
        row.selectorOptions = ["O mana", "Doua maini"]
        row.value = "O mana"
        section.addFormRow(row)
        row.tag = "rever"
        self.form = form
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector (savePressed(_:)));
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savePressed(_ button: UIBarButtonItem)
    {
        //butonul register a fost apasat
        let validationErrors : Array<NSError> = self.formValidationErrors() as! Array<NSError>
        if (validationErrors.count > 0){
            // se verifica erori de validare
            self.showFormValidationError(validationErrors.first)
            return
        }
        guard let mail = form.formRow(withTag: "email")?.value else {
            return;
        }
        guard let parola1 = form.formRow(withTag: "parola1")?.value else {
            return;
        }
        guard let parola2 = form.formRow(withTag: "parola2")?.value else {
            return;
        }
        guard let prenume = form.formRow(withTag: "prenume")?.value else {
            return;
        }
        guard let nume = form.formRow(withTag: "nume")?.value else {
            return;
        }
        guard let judet = form.formRow(withTag: "judet")?.value else {
            return;
        }
        guard let localitate = form.formRow(withTag: "localitate")?.value else {
            return;
        }
        guard let sex = form.formRow(withTag: "sex")?.value else {
            return;
        }
        guard let dataNasterii = form.formRow(withTag: "datanastere")?.value else {
            return;
        }
        // dupa colectarea datelor se verifica daca parolele sunt identice
        self.tableView.endEditing(true)
        if (parola1 as! String != parola2 as! String){
            print ("parolele nu sunt la fel")
            SCLAlertView().showError("Eroare", subTitle: "Parolele nu sunt identice");
            return;
        }
        // se verifica daca mail-ul este folosit deja
        Alamofire.request("http://graphichouse.ro/adrian/useri.php?mail=\(mail)").responseJSON { response in
            if (String (describing :response).contains("SUCCESS")){
                let url = URL(string: "http://graphichouse.ro/adrian/insert-useri.php?mail=\(mail)&parola=\(parola1)&prenume=\(prenume)&nume=\(nume)&data_nasterii=\((dataNasterii as! Date).toString2())&sex=\(sex as! String == "Masculin" ? "1" : "0")&judet=\(judet)&localitate=\(localitate)&data_inscriere_in_circuit=\(Date ().toString2())")
                if (url != nil){
                    URLSession.shared.dataTask(with: url!, completionHandler: {
                        (data, response, error) in
                        if(error != nil){
                            print("error")
                        }else{
                            self.retrieveJsonFromData(data!)
                        }
                    }).resume()
                }else {
                    SCLAlertView().showError("Eroare", subTitle: "Fara spatii in nume localitate judet etc");
                }
            }else {
                SCLAlertView().showError("Eroare", subTitle: "Adresa de email a fost deja folosita.");
            }
        }
    }
    
    func retrieveJsonFromData(_ data: Data){
        // se parseaza json de la server 
        /* Now try to deserialize the JSON object into a dictionary */
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary,
                let result = json["result"] as? String{
                if (result == "Fail") {
                    DispatchQueue.main.async(){
                        //write your code
                        SCLAlertView().showError("Eroare", subTitle: "A aparut o eroare, incercati din nou.");
                    }
                    
                }else {
                    DispatchQueue.main.async(){
                        //write your code
                        let alert = SCLAlertView()
                        alert.addButton("OK") {
                            _ = self.navigationController?.popViewController(animated: true);
                        }
                        alert.showInfo("Success", subTitle: "Ai fost inregistrat cu success!")
                    }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        
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
    
