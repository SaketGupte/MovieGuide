//
//  ListingView.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController,
                             UITableViewDataSource,
                             UITabBarDelegate,
                             ListingView {

  @IBOutlet weak var tableView = UITableView()
  @IBOutlet weak var sortByButton = UIButton()

  var movies:[MovieListModel] = []


  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: "")!
  }

  func showListOfMovie(movieList: [MovieListModel]) {
  }

}
