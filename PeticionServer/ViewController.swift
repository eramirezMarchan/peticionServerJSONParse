//
//  ViewController.swift
//  PeticionServer
//
//  Created by Faktos on 22/05/16.
//  Copyright © 2016 ERM. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var txtArea_response: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txt_search.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let urlSearch = urls + txt_search.text!
        let url = NSURL(string: urlSearch)
        let session = NSURLSession.sharedSession()
        let bloque = { (datos:NSData?, resp:NSURLResponse?, error : NSError?) -> Void in
            if(error?.code != -1009){
                let texto = NSString(data: datos!,encoding: NSUTF8StringEncoding)
                dispatch_sync(dispatch_get_main_queue()) {
                    self.txtArea_response.text = texto as! String
                }
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "No hay conexion a internet", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        let dt = session.dataTaskWithURL(url!, completionHandler: bloque)
        dt.resume()
        
        return true
    }


}

