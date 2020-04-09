//
//  MemeTableViewController.swift
//  MeMe App
//
//  Created by Gerardo Tarazona Caceres on 3/28/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

protocol ReloadInfoDelegate {
    func reloadView()
}

class MemeTableViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyMemesLabel: UILabel!
    
    // MARK: - Properties
    var memes: [Meme] {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.memes ?? []
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        showEmptyViewIfNeeded()
    }
    //MARK: - View Updates
    func showEmptyViewIfNeeded() {
        if memes.count > 0 {
            tableView.isHidden = false
            emptyMemesLabel.isHidden = true
        } else {
            tableView.isHidden = true
            emptyMemesLabel.isHidden = false
        }
    }
    //MARK: - CellRegistration
    func registerCell() {
        let bundle = Bundle(for: MemeTableViewController.self)
        let nib = UINib(nibName: Constants.NibNames.memeTableCell, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: Constants.ReuseIdentifiers.memeTableCell)
    }
    
}

extension MemeTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifiers.memeTableCell) as? MemeTableViewCell
        cell?.setupCellWith(meme: meme)
        return cell ?? UITableViewCell()
    }
}

extension MemeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        storyboard?.instantiateViewController(withIdentifier: Constants.storyBoardsIdentifiers.detailMemeView)
    }
}
