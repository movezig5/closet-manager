//
//  ViewController.swift
//  Closet Manager
//
//  Created by Daniel Ziegler on 3/13/16.
//  Copyright © 2016 CSC471. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var clothing: ClothingItem?
    
    override func viewDidAppear(animated: Bool) {
        if let item = clothing {
            nameLabel.text = item.name;
            typeLabel.text = item.type.rawValue;
            colorLabel.text = item.color;
            if(item.numSize == 0){
                sizeLabel.text = item.size;
            }
            else{
                sizeLabel.text = "\(item.numSize)";
            }
            descriptionLabel.text = item.desc;
            
            imageView.contentMode = .ScaleAspectFit;
            imageView.image = item.image;
            
        }
    }
    
    @IBAction func deleteItem(sender: UIButton) {
        if let item = clothing {
            for(var i = 0; i < clothingList.count; i++) {
                if(clothingList[i].id == item.id){
                    clothingList.removeAtIndex(i);
                    saveClothes();
                    break;
                }
            }
        }
        navigationController?.popViewControllerAnimated(true);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let editViewController = segue.destinationViewController as? EditViewController{
            editViewController.clothing = clothing;
        }
    }
    
    // MARK: NSEncoding
    func saveClothes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(clothingList, toFile: ClothingItem.ArchiveURL.path!);
        if !isSuccessfulSave {
            print("Failed to save clothing list.");
        }
    }

}

