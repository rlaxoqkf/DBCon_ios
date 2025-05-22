//
//  BottomSheetContentViewController.swift
//  DemoUIShowcase
//
//  Created by mobile on 5/20/25.
//

import UIKit

class BottomSheetContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    let data = ["손보정보서비스팀", "금융정보서비스팀", "하이텍정보서비스팀", "생명정보서비스팀", "디지털혁신파트"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
