//
//  UploadPostController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 21.06.2023.
//

import UIKit

protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    
    weak var delegate: UploadPostControllerDelegate?
    var currentUser: User?
    
    let genusPicker = UIPickerView()
    let cityPicker = UIPickerView()
    
    var genus = ["Cat","Dog","Other"]
    var sehir = ["Adana","Ankara","Bursa","Diyarbakir","Istanbul","Izmir","Konya","Mersin","Samsun","Trabzon","Van"]
    
    var genusName: String?
    var cityName: String?
    
    let doneButton = UIButton(type: .system)
    let doneButton1 = UIButton(type: .system)

    let genusButton = UIButton(type: .system)
    let cityButton = UIButton(type: .system)
    
        var selectedImage: UIImage? {
        didSet {
            photoImageView.image = selectedImage
        }
    }
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter caption.."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = .black.withAlphaComponent(0.8)
        tv.placeholderShouldCenter = false
        tv.textColor = .white
        tv.layer.cornerRadius = 5
        tv.delegate = self
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/1000"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureGenusButton()
        configureCityButton()
        configureGenusPicker()
        configureCityPicker()
        configureDoneButton()
        configureDoneButton1()
    }
    
 
    func configureGenusButton(){
         
        genusButton.setTitle("Genus", for: .normal)
        genusButton.addTarget(self, action: #selector(showGenusPicker), for: .touchUpInside)
        genusButton.backgroundColor = .black.withAlphaComponent(0.8)
        genusButton.setTitleColor(.white, for: .normal)
        genusButton.layer.cornerRadius = 5
        genusButton.frame = CGRect(x: 40, y: 400, width: 150, height: 40)
                    view.addSubview(genusButton)
        
    }
    func configureCityButton(){
         
        cityButton.setTitle("City", for: .normal)
        cityButton.addTarget(self, action: #selector(showCityPicker), for: .touchUpInside)
        cityButton.backgroundColor = .black.withAlphaComponent(0.8)
        cityButton.setTitleColor(.white, for: .normal)
        cityButton.layer.cornerRadius = 5
        cityButton.frame = CGRect(x: 235, y: 400, width: 150, height: 40)
        view.addSubview(cityButton)
        
    }
    func configureCityPicker(){
        
        cityPicker.isHidden = true
        cityPicker.delegate = self
        cityPicker.dataSource = self
        view.addSubview(cityPicker)
        cityPicker.frame = CGRect(x: 0, y: view.frame.height / 1.32, width: view.frame.width, height: view.frame.height / 4)
        cityPicker.backgroundColor = .black.withAlphaComponent(0.9)
        cityPicker.setValue(UIColor.white, forKey: "textColor")
      
    }
    func configureGenusPicker(){
        
        genusPicker.isHidden = true
        genusPicker.delegate = self
        genusPicker.dataSource = self
        view.addSubview(genusPicker)
        genusPicker.frame = CGRect(x: 0, y: view.frame.height / 1.32, width: view.frame.width, height: view.frame.height / 4)
        genusPicker.backgroundColor = .black.withAlphaComponent(0.9)
        genusPicker.setValue(UIColor.white, forKey: "textColor")
      
    }
    func configureDoneButton(){
        
    doneButton.setTitle("Done", for: .normal)
    doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    doneButton.backgroundColor = .black.withAlphaComponent(0.9)
    doneButton.setTitleColor(.white, for: .normal)
    view.addSubview(doneButton)
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    doneButton.widthAnchor.constraint(equalToConstant: genusPicker.frame.width).isActive = true
    doneButton.heightAnchor.constraint(equalToConstant: 30)
    doneButton.bottomAnchor.constraint(equalTo: genusPicker.topAnchor).isActive = true
    doneButton.isHidden = true
        
    }
    
    func configureDoneButton1(){
        
    doneButton1.setTitle("Done", for: .normal)
    doneButton1.addTarget(self, action: #selector(doneButtonTapped1), for: .touchUpInside)
    doneButton1.backgroundColor = .black.withAlphaComponent(0.9)
    doneButton1.setTitleColor(.white, for: .normal)
    view.addSubview(doneButton1)
    doneButton1.translatesAutoresizingMaskIntoConstraints = false
    doneButton1.widthAnchor.constraint(equalToConstant: cityPicker.frame.width).isActive = true
    doneButton1.heightAnchor.constraint(equalToConstant: 30)
    doneButton1.bottomAnchor.constraint(equalTo: cityPicker.topAnchor).isActive = true
    doneButton1.isHidden = true
        
    }
    
    @objc func showGenusPicker() {
        genusPicker.isHidden = false
        doneButton.isHidden = false
    }
    
    @objc func showCityPicker() {
        cityPicker.isHidden = false
        doneButton1.isHidden = false
        
    }
    
    @objc func doneButtonTapped() {
            let selectedRow = genusPicker.selectedRow(inComponent: 0)
            let selectedGenus = genus[selectedRow]
        printGenusName(name: selectedGenus)
        genusPicker.isHidden = true
        doneButton.isHidden = true
        
        }
    @objc func doneButtonTapped1() {
        
            let selectedRow = cityPicker.selectedRow(inComponent: 0)
            let selectedCity = sehir[selectedRow]
        printCityName(name: selectedCity)
            cityPicker.isHidden = true
        doneButton1.isHidden = true
        
        }
    
    func printGenusName(name: String) {
        
        self.genusName = name
        
        }
    func printCityName(name:String){
        self.cityName = name
        
    }
    
    @objc func didTapCancel(){
        dismiss(animated: true)
    }
    @objc func didTapDone(){
        guard let image = selectedImage else {return}
        guard let caption = captionTextView.text else {return}
        guard let user = currentUser else {return}
        
        showLoader(true)
      
        PostService.uploadPets(genus: genusName!,city: cityName!,caption: caption, image: image, user: user) { error in
                self.showLoader(false)
                if let error = error {
                    print("debug Failed to uploadd post with \(error.localizedDescription)")
                    return
                
        }
                    self.delegate?.controllerDidFinishUploadingPost(self)
            self.dismiss(animated: true)
        }
    }
    func checkMaxLength(_ textView: UITextView){
        if (textView.text.count) > 1000 {
            textView.deleteBackward()
        }
    }
    
    func configureUI(){
        
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 200, width: 200)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor, paddingTop: 150,paddingLeft: 12,paddingRight: 12,height: 200)
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor,right: view.rightAnchor,paddingBottom: 10,paddingRight: 20)
    }
}
extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/1000"
    }
}
extension UploadPostController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genusPicker {
            return genus.count
        }else{return sehir.count}
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == genusPicker {
            return genus[row]
        }else {
            return sehir[row]
        }
        
    }
    
    func configureNotificationObservers() {
        genusButton.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        cityButton.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    @objc func textDidChange(sender: UIButton){
        if sender == genusButton {
            print("erdal")
        }else {
           print("galatasary")
        }
    }
    
    
    
    
    
    
}
