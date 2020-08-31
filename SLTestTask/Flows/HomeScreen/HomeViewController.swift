//
//  ViewController.swift
//  SLTestTask
//
//  Created by apple on 8/27/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

// MARK: - Constants
fileprivate enum Constants {
    static let apiKey = "993da9372678f88552da6ee78e942f0f"
    static let popular = "popular"
    static let upcoming = "upcoming"
    static let topRated = "top_rated"
    static let segmentControlOptions = ["Popular", "Upcoming", "Top Rated"]
}

final class HomeViewController: UIViewController {
    
    // MARK: - Collection View outlet
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    // MARK: - Model & SegmentControl
    private var films: Films?
    private var segment: UISegmentedControl = UISegmentedControl(items: Constants.segmentControlOptions)
    private var selectedSegmentIndex: Int?
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControlSetup()
    }
    
    
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        request(URLString: makingURL(ParameterForUrl: Constants.popular))
        
        setGradientBackhroundForCollectionView()
        setGradientBackgroundForNavigationBar()
    }
    
}

// MARK: - Collection View Delegate & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        films?.results.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as! CustomFilmCollectionViewCell
        
        cell.backgroundColor = UIColor.white
        cell.shadowDecorate()
        
        
        guard let films = self.films?.results[indexPath.row] else {
            cell.titleLabel.text = "Network Error"
            cell.descriptionLabel.text = ""
            return cell
        }
        
        
        cell.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        let imageURL = "https://image.tmdb.org/t/p/w500\(films.poster_path)"
        
        cell.posterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "No_image"))
        cell.titleLabel.text = films.title.trunc(length: 50)
        cell.descriptionLabel.text = films.overview.trunc(length: 250)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsViewController" {
            let detailsVC: DetailsViewController = segue.destination as! DetailsViewController
            let indexPath = collectionView.indexPathsForSelectedItems?.last
            
            if films?.results[indexPath!.row].id != nil {
                detailsVC.filmID = (films?.results[indexPath!.row].id)!
            }
            detailsVC.selectedSegmentIndex = self.selectedSegmentIndex
        }
    }
    
    // Custom Appears animation
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsViewController", sender: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

// MARK: - Request
private extension HomeViewController {
    func request(URLString: String) {
        guard let url = URL(string: URLString) else {
            print("Request func: URL has value \(URLString)")
            return
        }
        AF.request(url)
            .responseDecodable { (response: DataResponse<Films,AFError>) in
                switch response.result {
                    
                case .success(let data):
                    self.films = data
                    self.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

// MARK: - Segment Control Setup
private extension HomeViewController {
    func segmentControlSetup() {
        
        segment.sizeToFit()
        segment.selectedSegmentTintColor = UIColor.blueAppColor
        
        
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleTextAttributesNotActive = [NSAttributedString.Key.foregroundColor: UIColor.blueAppColor]
        
        segment.setTitleTextAttributes(titleTextAttributesNotActive, for: .normal)
        segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segment.backgroundColor = UIColor.white
        
        segment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    // MARK: Selector for segment
    @objc func segmentValueChanged(target: UISegmentedControl) {
        switch target.selectedSegmentIndex {
        case 0:
            request(URLString: makingURL(ParameterForUrl: Constants.popular))
            selectedSegmentIndex = 0
        case 1:
            request(URLString: makingURL(ParameterForUrl: Constants.upcoming))
            selectedSegmentIndex = 1
        case 2:
            request(URLString: makingURL(ParameterForUrl: Constants.topRated))
            selectedSegmentIndex = 2
        default: break
        }
    }
}

// MARK: - Making URL by input parameters
private extension HomeViewController {
    func makingURL(ParameterForUrl parameter: String) -> String {
        
        let url = "https://api.themoviedb.org/3/movie/\(parameter)?api_key=\(Constants.apiKey)"
        
        return url
    }
}

// MARK: - Gradient Setup
private extension HomeViewController {
    func setGradientBackhroundForCollectionView() {
        
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = view.frame.size
        
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [UIColor.redAppColorCGColor, UIColor.blueAppColorCGColor]
        
        collectionView.backgroundView = collectionViewBackgroundView
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    
    func setGradientBackgroundForNavigationBar() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.redAppColorCGColor, UIColor.blueAppColorCGColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}


