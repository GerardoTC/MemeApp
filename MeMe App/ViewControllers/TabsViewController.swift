//
//  TabsViewController.swift
//  MeMe App
//
//  Created by Gerardo Tarazona Caceres on 3/28/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sent Memes"

        // Do any additional setup after loading the view.
    }
    @IBAction func showMemeEditor() {
        let memeEditor = (storyboard?.instantiateViewController(withIdentifier: Constants.storyBoardsIdentifiers.memeEditor))!
        memeEditor.modalPresentationStyle = .fullScreen
        self.present(memeEditor, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
