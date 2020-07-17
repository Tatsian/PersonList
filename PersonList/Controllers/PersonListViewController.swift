//
//  PersonListViewController.swift
//  PersonList
//
//  Created by Tatsiana on 13.07.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

final class PersonListViewController: UIViewController {
    @IBOutlet weak var modeSwitchButton: UIBarButtonItem!
    @IBOutlet weak var ageOrderButton: UIBarButtonItem!
    @IBOutlet weak var chooseGenderButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    private weak var tableVC: TableViewController?
    private weak var collectionVC: CollectionViewController?
    private weak var currentContentVC: UIViewController?
    private weak var currentRefreshControl: UIRefreshControl?
    
    private var currentMode: Mode = .table
    private let personsProvider = PersonsProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContentVC()
        
        currentRefreshControl?.beginRefreshing()
        personsProvider.reload { [weak self] in
            self?.updateContent()
            self?.currentRefreshControl?.endRefreshing()
        }
    }
    
    @IBAction func modeSwitchClicked(_ sender: UIBarButtonItem) {
        removeChild(viewController: currentContentVC)
        switch currentMode {
        case .table:
            currentMode = .collection
            sender.image = Mode.table.image
        case .collection:
            currentMode = .table
            sender.image = Mode.collection.image
        }
        addContentVC()
    }

    @IBAction func ageOrderClicked(_ sender: UIBarButtonItem) {
        switch personsProvider.selectedSort {
        case .ageAscending:
            personsProvider.selectedSort = .ageDescending
            sender.image = SortType.ageAscending.image
        case .ageDescending:
            personsProvider.selectedSort = .ageAscending
            sender.image = SortType.ageDescending.image
        }
        updateContent()
    }

    @IBAction func genderFilterClikced(_ sender: UIButton) {
        createGenderPicker()
    }
    
    @objc private func onStartRefresh() {
        personsProvider.reload { [weak self] in
            self?.updateContent()
            self?.currentRefreshControl?.endRefreshing()
        }
    }
    
    private func addContentVC() {
        switch currentMode {
        case .table:
            addTableSubview()
        case .collection:
            addCollectionSubview()
        }
    }
    
    private func updateContent() {
        tableVC?.tableView.reloadData()
        collectionVC?.collectionView.reloadData()
    }

    private func addTableSubview() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "tableBoard") as? TableViewController else {
            return
        }
        vc.personProvider = personsProvider
        add(asChildViewController: vc)
        
        vc.tableView.refreshControl = createRefreshControll()
        
        tableVC = vc
        currentContentVC = vc
    }

    private func addCollectionSubview() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "collectionBoard") as? CollectionViewController else {
            return
        }
        vc.personProvider = personsProvider

        add(asChildViewController: vc)
        
        vc.collectionView.refreshControl = createRefreshControll()
        
        collectionVC = vc
        currentContentVC = vc
    }
    
    private func createRefreshControll() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onStartRefresh), for: .valueChanged)
        currentRefreshControl = refreshControl
        return refreshControl
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: self)
        addChild(viewController)
    
        containerView.addSubview(viewController.view)
    
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
        viewController.didMove(toParent: self)
    }

    
    private func removeChild(viewController: UIViewController?) {
        viewController?.willMove(toParent: nil)
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
    }
    
    func createGenderPicker() {
        let picker = GenderPickerView(
            genders: Array(personsProvider.genders),
            selectedValue: personsProvider.selectedGender) { [weak self] selectedGender in
                guard let self = self else { return }
                self.personsProvider.selectedGender = selectedGender
                let buttonTitle = selectedGender ?? "Choose gender"
                self.chooseGenderButton.setTitle(buttonTitle, for: .normal)
                self.updateContent()
        }
        picker.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.size.height - picker.bounds.height)
        view.addSubview(picker)
    }
}
