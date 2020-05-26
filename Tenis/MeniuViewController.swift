//
//  MeniuViewController.swift
//  Tenis
//
//  Created by Edi Stern on 6/22/17.
//  Copyright © 2017 Edi Stern. All rights reserved.
//

import UIKit

class MeniuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // functionalitati butoane
    @IBAction func logout ()
    {
        UserDefaults.standard.setValue("", forKey: "txtUser")
        UserDefaults.standard.setValue("", forKey: "txtPasswd")
        Utils.userCurent = User ();
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func goToProfile ()
    {
        ProfileViewController.user = Utils.userCurent;
        self.performSegue(withIdentifier: "goToProfile", sender: self)
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
