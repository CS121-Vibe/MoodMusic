//
//  ViewController.swift
//  MoodMusic
//
//  Created by Omari Matthews and Nina Samko on 10/28/19.
//  Copyright © 2019 Vibe. All rights reserved.
//

import AVFoundation
import Foundation
import Photos
import SpriteKit
import UIKit



class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    let allQuestions = QuestionBank()
    var questionNumber : Int = 0
    var answers = [String]()
    
    var photoSetting = AVCapturePhotoSettings()
    
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    // Set up for the slider
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            // Configure camera
        photoSetting = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoSetting.isAutoStillImageStabilizationEnabled = true
        photoSetting.flashMode = .off
        
 
    }
    
    @objc func sliderInAction(sender: UISlider){
        label.text = String(sender.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose anything else
    }
    //action function of survey button at the home page. it takes user from home page to survey
    @IBAction func surveyButtonPressed(_ sender: UIButton) {
        nextQuestion()
    }
    
    //action function of camera button at the home page. it takes user from home page to camera
    // TODO: Fix camera crash. Could be due to a failure to allocate enough memory
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        
        // Check if a camera is available on the device
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let vc = UIImagePickerController()
            vc.delegate = self;
            vc.sourceType = .camera
            
            // Do not edit so the black screen with a frame does not appear
            vc.allowsEditing = false
            // Camera controller (default IOS animation)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //action function of photos button at the home page. it takes user from home page to their photos album
    // Done with the help of //https://turbofuture.com/cell-phones/Access-Photo-Camera-and-Library-in-Swift
    @IBAction func photosButtonPressed(_ sender: UIButton) {
        // Checks for access to Photo Library
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
             let vc = UIImagePickerController()
             vc.delegate = self;
             vc.sourceType = .photoLibrary
             vc.allowsEditing = false
            self.present(vc, animated: true, completion: nil)
         }
    }
    
    //gets called by the image picker when an image was selected. You need to read it out of the info dictionary using the key .editedImage, but then you have a UIImage that you can do whatever you want with
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagePicked.image = image
            dismiss(animated:true, completion: nil)
        
        }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        self.dismiss(animated: true, completion: nil)

    }
   
    // handles survey button presses
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        answers.append(sender.titleLabel?.text ?? "no answer")
        
        questionNumber += 1
        
        nextQuestion()
    }
    
    @IBAction func sliderValue(_sender: Any) {
        label.text = "\(slider.value)"
    }
    
    // updates the UI to display all the info pertaining to the next question
    func updateUI() {
        //magic numbers
        self.view.backgroundColor = UIColor(red: 28.05/255.0, green: 20.4/255.0, blue: 99.45/255.0, alpha: 1.0)
        let screenSize: CGRect = UIScreen.main.bounds
        var btnY = Int(screenSize.height)/2
        let btnHeight = 40
        
        //clears screen to add the new question
        for view in self.view.subviews{
                view.removeFromSuperview()
        }
        
        // add the text of the question at the top
        let question = UILabel()
        question.text  = allQuestions.list[questionNumber].questionText
        question.textColor = UIColor.white
        question.font = question.font.withSize(30)
        question.frame = CGRect(x: (Int(screenSize.width)/2)-200, y: 100, width: 400, height: 150)
        question.textAlignment = NSTextAlignment.center
        self.view.addSubview(question)
        
        //add a number of buttons to represent the number of choices for the questions
        for index in allQuestions.list[questionNumber].options.indices {
            let btn = UIButton()
            btn.setTitle(allQuestions.list[questionNumber].options[index], for: .normal)
            btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            btn.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
            btn.frame = CGRect(x: (Int(screenSize.width)/2)-100, y: btnY, width: 200, height: btnHeight)
            btn.contentMode = UIView.ContentMode.scaleToFill
            btnY += btnHeight + 5
            btn.addTarget(self, action: #selector(self.optionButtonPressed(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
            
        }
        
    }
    
    // Advances to the next question in the question list
    func nextQuestion() {
        if questionNumber < 4 {
            //questionLabel.text  = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            viewPlaylists()
        }
    
    }
    
    // Returns user to
    func startOver() {
        questionNumber = 0
        nextQuestion()
        answers = [String]()
        
    }
    
    // function views suggested playlists after user fills in the form

    func viewPlaylists(){
        // magic number
        let screenSize: CGRect = UIScreen.main.bounds
        let playlistHeight = Int(((screenSize.height-150)/3))
        //clears screen to add the new question
        for view in self.view.subviews{
                view.removeFromSuperview()
        }
        //add three suggestions
        for s in 1...3{
            //add the label
            let label = UILabel()
            label.text  = "Playlist " + String(s)
            label.textColor = UIColor.white
            label.frame = CGRect(x:20, y: 30+(playlistHeight*(s-1)), width: 400, height: 150)
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            self.view.addSubview(label)
            
            //add the picture
            let pic = #imageLiteral(resourceName: "default-album-art.png")
            let imageView = UIImageView(image: pic)
            imageView.frame = CGRect(x:20, y: 130+(playlistHeight*(s-1)), width: Int(screenSize.width/2)-30, height: Int(screenSize.width/2)-30)
            self.view.addSubview(imageView)

            // add the view button
            // Specify the settings (color, size etc.)
            let viewBtn = UIButton()
            viewBtn.setTitle("View", for: .normal)
            viewBtn.backgroundColor = UIColor(red:0.64, green:0.61, blue:1.00, alpha:1.0)
            viewBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            viewBtn.titleLabel?.font =  .systemFont(ofSize: 22)
            viewBtn.frame = CGRect(x: Int(screenSize.width/2)+20, y: 130+(playlistHeight*(s-1)), width: Int(screenSize.width/2)-30, height: Int(screenSize.width/4)-40)
            viewBtn.contentMode = UIView.ContentMode.scaleToFill
            viewBtn.addTarget(self, action: #selector(self.viewButtonPressed(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(viewBtn)
            
            // Add the play button
            // Specify the settings (color, size etc.)
            let playBtn = UIButton()
            playBtn.setTitle("Play", for: .normal)
            playBtn.backgroundColor = UIColor(red:0.64, green:0.61, blue:1.00, alpha:1.0)
            playBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            playBtn.titleLabel?.font =  .systemFont(ofSize: 22)
            playBtn.frame = CGRect(x: Int(screenSize.width/2)+20, y: 130+(playlistHeight*(s-1)) + Int(screenSize.width/4)-30, width: Int(screenSize.width/2)-30, height: Int(screenSize.width/4)-40)
            playBtn.contentMode = UIView.ContentMode.scaleToFill
            playBtn.addTarget(self, action: #selector(self.playButtonPressed(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(playBtn)
        }
        
        // add the 'start over' button
        // Specify the settings (color, size etc.)
        let startOverBtn = UIButton()
        startOverBtn.setTitle("Start Over", for: .normal)
        startOverBtn.backgroundColor = UIColor(red:0.64, green:0.61, blue:1.00, alpha:1.0)
        startOverBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        startOverBtn.titleLabel?.font =  .systemFont(ofSize: 22)
        startOverBtn.frame = CGRect(x: Int(screenSize.width/2)+40, y: 800, width:
            Int(screenSize.width/2)-45, height: Int(screenSize.width/4)-40)
        startOverBtn.contentMode = UIView.ContentMode.scaleToFill
        startOverBtn.addTarget(self, action: #selector(self.startOverButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(startOverBtn)
    }
    
    // Creates a new UI page with a list of songs
    func showSongs() {
        // magic number
        let screenSize: CGRect = UIScreen.main.bounds
        let playlistHeight = Int(((screenSize.height-150)/3))
        //clears screen to add the new question
        for view in self.view.subviews{
                view.removeFromSuperview()
        }
        
        // Add Title
        let label = UILabel()
        label.text  = "Playlist "
        label.textColor = UIColor.white
        label.frame = CGRect(x:20, y:30, width: 400, height: 150)
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        self.view.addSubview(label)
        
        // Add the picture
        // Specify the location
        let pic = #imageLiteral(resourceName: "default-album-art.png")
        let imageView = UIImageView(image: pic)
        imageView.frame = CGRect(x:20, y: 130, width: Int(screenSize.width/2)-30, height: Int(screenSize.width/2)-30)
        self.view.addSubview(imageView)
        
        // Add the go back button
        // Specify the settings (color, size etc.)
        let backBtn = UIButton()
        backBtn.setTitle("Back", for: .normal)
        backBtn.backgroundColor = UIColor(red:0.64, green:0.61, blue:1.00, alpha:1.0)
        backBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        backBtn.titleLabel?.font =  .systemFont(ofSize: 22)
        backBtn.frame = CGRect(x: Int(screenSize.width/2)-200, y: 800, width: Int(screenSize.width/2)-30, height: Int(screenSize.width/4)-40)
        backBtn.contentMode = UIView.ContentMode.scaleToFill
        backBtn.addTarget(self, action: #selector(self.backButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(backBtn)
  }
 
    
    // Creates a new UI page with a list of songs
       func playSongs() {
           // magic number
           let screenSize: CGRect = UIScreen.main.bounds
           let playlistHeight = Int(((screenSize.height-150)/3))
           //clears screen to add the new question
           for view in self.view.subviews{
                   view.removeFromSuperview()
           }
            // Add the go back button
            // Specify the settings (color, size etc.)
            let backBtn = UIButton()
            backBtn.setTitle("Back", for: .normal)
            backBtn.backgroundColor = UIColor(red:0.64, green:0.61, blue:1.00, alpha:1.0)
            backBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            backBtn.titleLabel?.font =  .systemFont(ofSize: 22)
            backBtn.frame = CGRect(x: Int(screenSize.width/2)-200, y: 800, width: Int(screenSize.width/2)-30, height: Int(screenSize.width/4)-40)
            backBtn.contentMode = UIView.ContentMode.scaleToFill
            backBtn.addTarget(self, action: #selector(self.backButtonPressed(_:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(backBtn)
    }
    
    // Returns user to the beginning of the survey
       @IBAction func startOverButtonPressed(_ sender: UIButton){
        startOver();
       }
    
    // Returns user back to playlists
    @IBAction func backButtonPressed(_ sender: UIButton){
        viewPlaylists();
    }
    
    // User wants to view songs in the playlist
    @IBAction func viewButtonPressed(_ sender: UIButton){
        showSongs();
    }

    // User wants to listen to playlist
    @IBAction func playButtonPressed(_ sender: UIButton){
        playSongs();
    }

}


//label = UILabel()
// label.frame = CGRect(x:0, y:30, width: self.view.frame.width, height:  self.view.frame.height)
// label.textColor = UIColor.white
// label.backgroundColor = UIColor.purple
// label.textAlignment = NSTextAlignment.center
// label.numberOfLines = 2
// label.font = UIFont(name: "Helvetica", size: 32)
// self.view.addSubview(label)
//
// slider = UISlider(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
// slider.center = self.view.center
// // Spotify's loundess metrics ranges from -60 to 0, so we will make [0,60] range for user's convenience
// slider.minimumValue = 0
// slider.maximumValue = 60
// slider.value = 30
// slider.tintColor = UIColor.cyan
// slider.thumbTintColor = UIColor.white
// slider.isContinuous = true
//
// self.view.addSubview(slider)
