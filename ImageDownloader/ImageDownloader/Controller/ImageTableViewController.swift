//
//  ImageTableViewController.swift
//  ImageDownloader
//
//  Created by Станислав Лемешаев on 05.03.2021.
//

import UIKit

class ImageTableViewController: UITableViewController {

    // MARK: - Properties
    
    private var images = [UnsplashPhoto]()
    private var networkDataFetcher = NetworkDataFetcher()
    private var currentPage: Int = 1
    private var isLoadingList: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helpers
    
    private func fetchImages(searchTerm: String, numberPage: Int) {
        self.networkDataFetcher.fetchImages(searchTerm: searchTerm, numberPage: numberPage) { [weak self] (searchResults) in
            guard let fetchedImages = searchResults else { return }
            self?.isLoadingList = false
            self?.images = fetchedImages.results
            self?.tableView.reloadData()
        }
    }
    
    private func loadMoreImages() {
        currentPage += 1
        fetchImages(searchTerm: "Blue", numberPage: currentPage)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList) {
            self.isLoadingList = true
            self.loadMoreImages()
        }
    }

}

// MARK: - Table view data source

extension ImageTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
        let unsplashPhoto = images[indexPath.row]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height(for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return height(for: indexPath)
    }
    
    private func height(for indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
}
