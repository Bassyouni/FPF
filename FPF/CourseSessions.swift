//
//  CourseSessions.swift
//  FPF
//
//  Created by Bassyouni on 10/20/17.
//  Copyright © 2017 Bassyouni. All rights reserved.
//

import UIKit

class CourseSessions: UIViewController  {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }



}

extension CourseSessions: UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "upComingSessionTableViewCell", for: indexPath) as? upComingSessionTableViewCell
            {
                return cell
            }
        }
        else if indexPath.section == 1
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "sessionsTableTableViewCell", for: indexPath) as? sessionsTableTableViewCell
            {
                return cell
            }
        }
        else if indexPath.section == 2
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "invitationsTableViewCell", for: indexPath) as? invitationsTableViewCell
            {
                return cell
            }
        }
        else if indexPath.section == 3
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell", for: indexPath) as? PriceTableViewCell
            {
                return cell
            }
        }

        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 125
        }
        else if indexPath.section == 1
        {
            return (424 - 40)
        }
        else if indexPath.section == 2
        {
            return 130
        }
        else if indexPath.section == 3
        {
            return 246
        }
        return 0
    }
}





