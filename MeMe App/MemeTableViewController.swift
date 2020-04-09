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
    
    // MARK: - Properties
    var memes: [Meme] {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.memes ?? []
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension MemeTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")
        cell?.imageView?.image = meme.memedImage
        cell?.textLabel?.text = meme.topText
        cell?.detailTextLabel?.text = meme.bottomText
        return cell ?? UITableViewCell()
    }
}
