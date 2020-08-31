//
//  DetailsViewController.swift
//  SLTestTask
//
//  Created by apple on 8/30/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class DetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var backgroundPosterImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.makeCornerRadius(View: posterImageView)
        }
    }
    
    @IBOutlet weak var labelsView: UIView! {
        didSet {
            labelsView.makeCornerRadius(View: labelsView)
            labelsView.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor.redAppColor
        }
    }
    
    @IBOutlet weak var yearLabel: UILabel!{
        didSet {
            yearLabel.textColor = UIColor.redAppColor
        }
    }
    
    @IBOutlet weak var genreLabel: UILabel!{
        didSet {
            genreLabel.textColor = UIColor.redAppColor
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet {
            descriptionLabel.textColor = UIColor.redAppColor
        }
    }
    
    // MARK: Variables
    private var filmDetails: DetailsModel?
    private var genreList: [String]?
    var selectedSegmentIndex: Int?
    var filmID = 0
    
    
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.themoviedb.org/3/movie/\(filmID)?api_key=993da9372678f88552da6ee78e942f0f"
        request(URLString: url)
        
        navigationBackButtonSetup()
        
        setGradientToNavigationBar()
    }
}

// MARK: - Set Values into the views fields
private extension DetailsViewController {
    func setValues() {
        titleLabel.text = filmDetails?.title
        descriptionLabel.text = filmDetails?.overview
        
        let parsed = filmDetails?.release_date.dropLast(6)
        yearLabel.text = String(parsed ?? "")
        
        guard let filmsPoster = filmDetails?.poster_path else { return }
        
        let imageURL = "https://image.tmdb.org/t/p/original\(filmsPoster)"
        
        backgroundPosterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        backgroundPosterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "No_image"))
        backgroundPosterImageView.addBlurEffect()
        posterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "No_image"))
        
        // Removes comma after last element of array
        var concatenatedString = ""
        if let genresArray = filmDetails?.genres {
            for (object) in genresArray {
                
                concatenatedString += object.name
                concatenatedString.insert(contentsOf: ", ", at: concatenatedString.endIndex)
            }
            if concatenatedString.last == " " {
                concatenatedString.removeLast(2)
            }
            self.genreLabel.text = concatenatedString
        }
    }
}

// MARK: - Set Navigation Bar Gradient
private extension DetailsViewController {
    func setGradientToNavigationBar() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.redAppColorCGColor, UIColor.blueAppColorCGColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

// MARK: - Request
private extension DetailsViewController {
    func request(URLString: String) {
        guard let url = URL(string: URLString) else {
            print("Request func: URL has value \(URLString)")
            return
        }
        AF.request(url)
            .responseDecodable { (response: DataResponse<DetailsModel,AFError>) in
                switch response.result {
                    
                case .success(let data):
                    self.filmDetails = data
                    self.setValues()
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

// MARK: - Navigation Back Button Setup
private extension DetailsViewController {
    func navigationBackButtonSetup() {
        let backButton = UIBarButtonItem()
        switch selectedSegmentIndex {
        case 0:
            backButton.title = "Popular"
        case 1:
            backButton.title = "Upcoming"
        case 2:
            backButton.title = "Top Rated"
        default:
            backButton.title = "Popular"
        }
        
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
