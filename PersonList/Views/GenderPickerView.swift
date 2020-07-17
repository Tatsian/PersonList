//
//  GenderPickerView.swift
//  PersonList
//
//  Created by Tatsiana on 16.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//


import UIKit

final class GenderPickerView: UIView {
    private let pickerHeight: CGFloat = 150
    private let toolbarHeight: CGFloat = 50
    
    private let genders: [String]
    private let completion: (String?) -> ()

    private var selectedGender: String?
    
    init(genders: [String], selectedValue: String?, completion: @escaping (String?) -> ()) {
        self.genders = genders.sorted()
        self.completion = completion
        super.init(frame:
            CGRect(origin: .zero, size:
            CGSize(width: UIScreen.main.bounds.size.width, height: pickerHeight + toolbarHeight)
        ))
        setup(selectedValue: selectedValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(selectedValue: String?) {
        let picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0,
                                   y: toolbarHeight,
                                   width: bounds.width,
                                   height: pickerHeight)
        addSubview(picker)
        
        let toolbar = UIToolbar.init(frame: CGRect.init(x: 0.0,
                                                    y: 0,
                                                    width: UIScreen.main.bounds.size.width,
                                                    height: 50))
        //toolbar.barStyle = .black
        toolbar.isTranslucent = true
        toolbar.items = [UIBarButtonItem.init(title: "Done",
                                              style: .done,
                                              target: self,
                                              action: #selector(doneButtonTapped))]
        addSubview(toolbar)
        
        if let selected = selectedValue, let selectedIndex = genders.firstIndex(of: selected) {
            picker.selectRow(selectedIndex + 1, inComponent: 0, animated: false)
        }
    }
    
    @objc func doneButtonTapped() {
        completion(selectedGender)
        removeFromSuperview()
    }
}

extension GenderPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count + 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "All"
        } else {
            return genders[row - 1]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            selectedGender = nil
        } else {
            selectedGender = genders[row - 1]
        }
    }
}


