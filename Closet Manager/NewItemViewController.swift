//
//  NewItemViewController.swift
//  Closet Manager
//
//  Created by Daniel Ziegler on 3/14/16.
//  Copyright © 2016 CSC471. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    
    var selected = "Shirt";
    
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var colorText: UITextField!
    @IBOutlet weak var sizeText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController();
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = types[row];
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    @IBAction func createItem(sender: UIButton) {
        clothingList.append(generateItem());
        saveClothes();
        navigationController?.popViewControllerAnimated(true);
    }
    
    func generateItem() -> ClothingItem {
        let newItem = ClothingItem();
        if let newName = nameText.text {
            newItem.name = newName;
        }
        else {
            newItem.name = "Untitled";
        }
        
        if let newColor = colorText.text {
            newItem.color = newColor;
        }
        else {
            newItem.color = "White";
        }
        
        if let newSize = sizeText.text {
            if(Int(newSize) != nil) {
                newItem.numSize = Int(newSize)!;
                newItem.size = "N/A";
            }
            else{
                newItem.numSize = 0;
                newItem.size = newSize;
            }
        }
        else{
            newItem.numSize = 0;
            newItem.size = "N/A";
        }
        
        switch(selected){
        case("Shirt"):
            newItem.type = .Shirt;
        case("Pants"):
            newItem.type = .Pants;
        case("Dress"):
            newItem.type = .Dress;
        case("Skirt"):
            newItem.type = .Skirt;
        case("Hat"):
            newItem.type = .Hat;
        case("Shoes"):
            newItem.type = .Shoes;
        case("Jacket"):
            newItem.type = .Jacket;
        case("Glove"):
            newItem.type = .Glove;
        case("Other"):
            newItem.type = .Other
        default:
            newItem.type = .Shirt;
        }
        
        if let newDescription = descriptionText.text {
            newItem.desc = newDescription;
        }
        else {
            newItem.desc = "";
        }
        
        if let lastItem = clothingList.last {
            newItem.id = lastItem.id + 1;
        }
        else {
            newItem.id = 0;
        }
        
        if let picture = imageView.image {
            newItem.image = picture;
        }
        
        return newItem;
        
    }

    @IBAction func cancelNewItem(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func backgroundTouched(sender: AnyObject) {
        for tf in textFields{
            tf.resignFirstResponder();
        }
    }
    
    @IBAction func nameEditingEnded(sender: UITextField) {
        sender.resignFirstResponder();
    }
    @IBAction func colorEditingDone(sender: UITextField) {
        sender.resignFirstResponder();
    }
    @IBAction func sizeEditingEnded(sender: UITextField) {
        sender.resignFirstResponder();
    }
    @IBAction func descriptionEditingEnded(sender: UITextField) {
        sender.resignFirstResponder();
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
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
