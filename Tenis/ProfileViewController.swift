//
//  ProfileViewController.swift
//  Tenis
//
//  Created by Edi Stern on 4/7/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit
import XLForm

class ProfileViewController: XLFormViewController {
    static var user = User ();
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(ProfileViewController.savePressed(_:)))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        row.value = ProfileViewController.user.nume;
        section.addFormRow(row)
        
        // Surame
        row = XLFormRowDescriptor(tag: Tags.Prenume, rowType: XLFormRowDescriptorTypeText, title: "Prenume")
        row.tag = "prenume"
        row.isRequired = true
        row.value = ProfileViewController.user.prenume;
        section.addFormRow(row)
        
        // Judet
        row = XLFormRowDescriptor(tag: Tags.Prenume, rowType: XLFormRowDescriptorTypeText, title: "Judet")
        row.tag = "judet"
        row.isRequired = true
        row.value = ProfileViewController.user.judet;
        section.addFormRow(row)
        
        // Localitate
        row = XLFormRowDescriptor(tag: Tags.Prenume, rowType: XLFormRowDescriptorTypeText, title: "Localitate")
        row.tag = "localitate"
        row.value = ProfileViewController.user.localitate;
        row.isRequired = true
        section.addFormRow(row)
        
        // Email
        row = XLFormRowDescriptor(tag: Tags.Email, rowType: XLFormRowDescriptorTypeEmail, title: "Email")
        row.tag = "email"
        row.value = ProfileViewController.user.mail;
        // validate the email
        row.addValidator(XLFormValidator.email())
        row.isRequired = true;
        section.addFormRow(row)
        
        
        // Telefon
        row = XLFormRowDescriptor(tag: Tags.Telefon, rowType: XLFormRowDescriptorTypeNumber, title: "Telefon")
        row.tag = "telefon"
        section.addFormRow(row)
        
        row.value = ProfileViewController.user.telefon;
        
        // Inaltime
        row = XLFormRowDescriptor(tag: Tags.Inaltime, rowType: XLFormRowDescriptorTypeZipCode, title: "Inaltime")
        row.tag = "inaltime"
        section.addFormRow(row)
        row.value = ProfileViewController.user.inaltime;
        
        // Greutate
        row = XLFormRowDescriptor(tag: Tags.Greutate, rowType: XLFormRowDescriptorTypeDecimal, title: "Greutate")
        row.tag = "greutate"
        section.addFormRow(row)
        row.value = ProfileViewController.user.greutate;
        
        // datanastere
        row = XLFormRowDescriptor(tag: Tags.DataNastere, rowType: XLFormRowDescriptorTypeDate, title: "Data Nastere")
        row.tag = "datanastere"
        section.addFormRow(row)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy" //Your date format
        let date = dateFormatter.date(from: ProfileViewController.user.data_nasterii)
        if (date != nil){
            row.value = date;
        }
        
        // sex
        row = XLFormRowDescriptor(tag :Tags.ManaFolosita, rowType:XLFormRowDescriptorTypeSelectorActionSheet, title:"Sex")
        row.selectorOptions = ["Masculin", "Feminin"]
        row.tag = "sex"
        row.value = ProfileViewController.user.sex == 1 ? "Masculin" : "Feminin";
        section.addFormRow(row)
        
        
        // mana de baza
        row = XLFormRowDescriptor(tag :Tags.ManaFolosita, rowType:XLFormRowDescriptorTypeSelectorActionSheet, title:"Mana de baza")
        row.selectorOptions = ["Stanga", "Dreapta"]
        row.tag = "mana"
        row.value = ProfileViewController.user.mana_de_joc == 1 ? "Stanga" : "Dreapta";
        section.addFormRow(row)
        
        // rever
        row = XLFormRowDescriptor(tag :Tags.ManaFolosita, rowType:XLFormRowDescriptorTypeSelectorActionSheet, title:"Rever")
        row.selectorOptions = ["O mana", "Doua maini"]
        row.value = ProfileViewController.user.rever == 1 ? "O mana" : "Doua maini";
        row.value = "O mana"
        section.addFormRow(row)
        row.tag = "rever"
        self.form = form
        
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

