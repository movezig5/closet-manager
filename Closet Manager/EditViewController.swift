//
//  EditViewController.swift
//  Closet Manager
//
//  Created by Daniel Ziegler on 3/15/16.
//  Copyright © 2016 CSC471. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let types = ["Shirt", "Pants", "Dress", "Skirt", "Hat", "Shoes", "Jacket", "Glove", "Other"];
    
    var clothing: ClothingItem?;
    
    var selectedType = "Shirt";
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var colorText: UITextField!
    @IBOutlet weak var sizeText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    
    let imagePicker = UIImagePickerController();
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = types[row];
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        if let item = clothing {
            nameText.text = item.name;
            selectedType = item.type.rawValue;
            colorText.text = item.color;
            if(item.numSize == 0){
                sizeText.text = item.size;
            }
            else{
                sizeText.text = "\(item.numSize)";
            }
            descriptionText.text = item.desc;
            
            if let picture = item.image {
                imageView.contentMode = .ScaleAspectFit;
                imageView.image = picture;
            }
        }
        typePicker.selectRow(types.indexOf(selectedType)!, inComponent: 0, animated: true);
    }
    

    @IBAction func backgroundTouched(sender: AnyObject) {
        for tf in textFields {
            tf.resignFirstResponder();
        }
    }
    
    @IBAction func nameEditDone(sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func colorEditDone(sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func sizeEditDone(sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func descriptionEditDone(sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func saveChanges(sender: UIButton) {
        if let item = clothing {
            
            if let newName = nameText.text {
                item.name = newName;
            }
            else {
                item.name = "Untitled";
            }
            
            if let newColor = colorText.text {
                item.color = newColor;
            }
            
            if let newSize = sizeText.text {
                if let newInt = Int(newSize) {
                    item.numSize = newInt;
                    item.size = "N/A";
                }
                else {
                    item.numSize = 0;
                    item.size = newSize;
                }
            }
            
            if let desc = descriptionText.text {
                item.desc = desc;
            }
            else {
                item.desc = "";
            }
            
            switch(selectedType){
            case("Shirt"):
                item.type = .Shirt;
            case("Pants"):
                item.type = .Pants;
            case("Dress"):
                item.type = .Dress;
            case("Skirt"):
                item.type = .Skirt;
            case("Hat"):
                item.type = .Hat;
            case("Shoes"):
                item.type = .Shoes;
            case("Jacket"):
                item.type = .Jacket;
            case("Glove"):
                item.type = .Glove;
            case("Other"):
                item.type = .Other;
            default:
                item.type = .Shirt;
            }
            
            if let picture = imageView.image {
                item.image = picture;
            }
            
            saveClothes();
            navigationController?.popViewControllerAnimated(true);
        }
    }
    
    @IBAction func cancelEdit(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker.allowsEditing = false;
        imagePicker.sourceType = .Camera;
        imagePicker.cameraCaptureMode = .Photo;
        imagePicker.modalPresentationStyle = .FullScreen;
        presentViewController(imagePicker, animated: true, completion: nil);
    }
    
    @IBAction func choosePhoto(sender: UIButton) {
        imagePicker.allowsEditing = false;
        imagePicker.sourceType = .PhotoLibrary;
        presentViewController(imagePicker, animated: true, completion: nil);
    }
    
    // MARK: NSEncoding
    func saveClothes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(clothingList, toFile: ClothingItem.ArchiveURL.path!);
        if !isSuccessfulSave {
            print("Failed to save clothing list.");
        }
    }
    
    // MARK: UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.contentMode = .ScaleAspectFit;
            imageView.image = pickedImage;
        }
        
        dismissViewControllerAnimated(true, completion: nil);
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
