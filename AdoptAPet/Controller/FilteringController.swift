//
//  FilteringController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 5.07.2023.
//

import UIKit

protocol incomingData: AnyObject {
    
    func data(genus: String, city: String )
}

class FilteringController: UIViewController {
    
    weak var delegate: incomingData?
    
    let genusPicker = UIPickerView()
    let cityPicker = UIPickerView()
    
    var genuss = ["All","Dog","Cat","Other"]
    var sehir = ["Turkey","Adana","Ankara","Bursa","Diyarbakir","Istanbul","Izmir","Konya","Mersin","Samsun","Trabzon","Van"]
    
    
    var genusName: String?
    var cityName: String?
    
    var city: String? {
        didSet {
            checkBothVariables()
        }
    }

    var cins: String? {
        didSet {
            checkBothVariables()
        }
    }

    func checkBothVariables() {
        guard let city = city, let cins = cins else {
            return
        }
        print("City: \(city), Cins: \(cins)")
        delegate?.data(genus: cins, city: city)
        dismiss(animated: true)
    }

    let doneButton = UIButton(type: .system)
    let doneButton1 = UIButton(type: .system)
    
    private let filteringTitle: UILabel = {

        let label = UILabel()
        label.text = "FILTERING"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white

        return label
    }()

    var genusButton:UIButton = {
        let button = UIButton()
        button.setTitle("Genus", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showGenusPicker), for: .touchUpInside)
        return button
    }()
    
    var cityButton:UIButton = {
        let button = UIButton()
        button.setTitle("City", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showCityPicker), for: .touchUpInside)
        return button
    }()
    
    @objc func showGenusPicker() {
        genusPicker.isHidden = false
        genusButton.isHidden = true
        cityButton.isHidden = true
        doneButton.isHidden = false

    }
    
    @objc func showCityPicker() {
        cityPicker.isHidden = false
        genusButton.isHidden = true
        cityButton.isHidden = true
        doneButton1.isHidden = false

    }
    @objc func doneButtonTapped() {
            let selectedRow = genusPicker.selectedRow(inComponent: 0)
            let selectedGenus = genuss[selectedRow]
        cins = selectedGenus
        genusPicker.isHidden = true
        doneButton.isHidden = true
        genusButton.isHidden = false
        cityButton.isHidden = false
        
        }
    
    @objc func doneButtonTapped1() {
            let selectedRow = cityPicker.selectedRow(inComponent: 0)
            let selectedCity = sehir[selectedRow]
           city = selectedCity
            cityPicker.isHidden = true
        doneButton1.isHidden = true
        genusButton.isHidden = false
        cityButton.isHidden = false
        
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDismissGesture()

        view.backgroundColor = .black.withAlphaComponent(0.8)
        let cornerRadius: CGFloat = 20.0
            let maskPath = UIBezierPath(roundedRect: view.bounds,
                                        byRoundingCorners: [.topLeft, .topRight],
                                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            view.layer.mask = maskLayer
        configureGenusPicker()
        configureCityPicker()
        configureDoneButton()
        configureDoneButton1()
        
        view.addSubview(filteringTitle)
        filteringTitle.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 50,paddingLeft: 150,paddingRight: 150)
        
        let mainDivider = UIView()
        mainDivider.backgroundColor = .white
        view.addSubview(mainDivider)
        mainDivider.anchor(top: filteringTitle.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 20,paddingLeft: 10,paddingRight: 10, height: 2)
        view.addSubview(genusButton)
        genusButton.anchor(top: filteringTitle.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 100,paddingLeft: 150,paddingRight: 150)
        view.addSubview(cityButton)
        cityButton.anchor(top: genusButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 30,paddingLeft: 150,paddingRight: 150)
        
    }
    
    private func setupDismissGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDismissGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc private func handleDismissGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let verticalOffset = translation.y
        
        switch gesture.state {
        case .changed:
            if verticalOffset > 0 {
                view.transform = CGAffineTransform(translationX: 0, y: verticalOffset)
            }
            
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: view)
            if verticalOffset > 0 && velocity.y > 0 {
                dismiss(animated: true, completion: nil)
            } else {
          
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
            
        default:
            break
        }
    }

    func configureCityPicker(){
        
    cityPicker.isHidden = true
    cityPicker.delegate = self
    cityPicker.dataSource = self
    view.addSubview(cityPicker)
    cityPicker.setValue(UIColor.white, forKey: "textColor")
    cityPicker.frame = CGRect(x: 0, y: 140, width: view.frame.width, height: view.frame.height / 4)
     
    }
    func configureGenusPicker(){
        
    genusPicker.isHidden = true
    genusPicker.delegate = self
    genusPicker.dataSource = self
    view.addSubview(genusPicker)
    genusPicker.setValue(UIColor.white, forKey: "textColor")
    genusPicker.frame = CGRect(x: 0, y: 140, width: view.frame.width, height: view.frame.height / 4)
        
    }
    
    func configureDoneButton(){
    doneButton.setTitle("DONE", for: .normal)
    doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    doneButton.setTitleColor(.white, for: .normal)
    view.addSubview(doneButton)
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    doneButton.widthAnchor.constraint(equalToConstant: genusPicker.frame.width).isActive = true
    doneButton.heightAnchor.constraint(equalToConstant: 30)
    doneButton.bottomAnchor.constraint(equalTo: genusPicker.topAnchor).isActive = true
    doneButton.isHidden = true
        
    }
    
    func configureDoneButton1(){
        
    doneButton1.setTitle("DONE", for: .normal)
    doneButton1.addTarget(self, action: #selector(doneButtonTapped1), for: .touchUpInside)
    doneButton1.setTitleColor(.white, for: .normal)
    view.addSubview(doneButton1)
    doneButton1.translatesAutoresizingMaskIntoConstraints = false
    doneButton1.widthAnchor.constraint(equalToConstant: cityPicker.frame.width).isActive = true
    doneButton1.heightAnchor.constraint(equalToConstant: 30)
    doneButton1.bottomAnchor.constraint(equalTo: cityPicker.topAnchor).isActive = true
    doneButton1.isHidden = true
        
    }
    
}

extension FilteringController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genusPicker {
            return genuss.count
        }else{return sehir.count}
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == genusPicker {
            return genuss[row]
        }else {
            return sehir[row]
        }
        
    }
}
    
