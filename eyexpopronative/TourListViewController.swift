//
//  TourListSecondViewController.swift
//  eyexpopronative
//
//  Created by Thompson Sanjoto on 2018-07-12.
//  Copyright © 2018 eyexpo. All rights reserved.
//

import UIKit
import SDWebImage
import WebKit
import SwiftyJSON

class TourListViewController: UITableViewController {

    var tours:[Tour] = []
    let placeholderImage = UIImage(named: "grey")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!) // not required when using UITableViewController
        self.refresh(sender: self)
        
        let nib = UINib(nibName: "TourCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        NetworkManager.shared.getPublicTours(){ (err, succ) in
            if let err = err
            {
                print("error: \(err)")
            }else if let succ = succ
            {
                let data = JSON(succ)
                let toursData = data["publictours"].arrayValue
                self.tours = []
                for tourData in toursData{
                    self.tours.append(Tour(tour: tourData))
                }
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenRect = UIScreen.main.bounds
        let screenHeight = screenRect.size.height
        
        let navBarHeight =  self.navigationController!.navigationBar.frame.size.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        return (screenHeight - navBarHeight - statusBarHeight) / 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tours.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TourCell
        cell.title.text = tours[indexPath.row].title
        
        if let imgUrl = URL(string:tours[indexPath.row].cover_img_thumbnail_url) {
            cell.thumbView.sd_setImage(with: imgUrl, placeholderImage: placeholderImage){ (image, error, cache, url) in
                cell.panoView.load(image)
            }
        }

        cell.thumbView.isHidden = true
        cell.panoView.isHidden = false
        cell.tapContainer.isHidden = false
        cell.panoView.load(cell.thumbView.image!)

        if cell.tapContainer.gestureRecognizers ==  nil {
            cell.tapContainer.tag = indexPath.row
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(liveViewTapped(tapGestureRecognizer:)))
            cell.tapContainer.addGestureRecognizer(tapGestureRecognizer)
        }
        
        return cell
    }
    
    @objc func liveViewTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let liveView = tapGestureRecognizer.view!
        let indexPath = IndexPath(row: liveView.tag, section: 0)
        self.tableView(self.tableView, didSelectRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fullTourSecond", sender:tours[indexPath.row].tour_url )
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fullTour = segue.destination as! WebViewController
        let url = sender as! String
        fullTour.url = url
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        let appdelegate = UIApplication.shared.delegate!
        let nav = UINavigationController(rootViewController: controller)
        appdelegate.window!!.rootViewController = nav
    }
    
}

