//
//  NewsFeedController.swift
//  NewsAppChallenge
//
//  Created by Samuel Mejia Guarin on 3/09/18.
//  Copyright © 2018 Samuel Mejia Guarin. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper
import Foundation
import UIKit
import SDWebImage

class NewsFeedViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    var newsData:NewsDataModel?
    let url:String = "https://newsapi.org/v2/top-headlines?q=games&apiKey=60e10b1325f34ed383ba7da9359cdaa7"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getNewsData(url: url){ (articles:[Article]) in
            DispatchQueue.main.async {
            self.setupSlideScrollView(news: articles)
            }
        }
        self.view.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.05, alpha:1.0)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNewsData(url: String,completion: @escaping ([Article]) -> Void) {
        
        
        
        Alamofire.request(url,method: .get).responseObject{
            (response: DataResponse<NewsDataModel>) in
            switch response.result{
            case .success:
                self.newsData = response.result.value!
                completion((self.newsData?.articles)!!)
//                DispatchQueue.main.async {
//                    self.setupSlideScrollView(news: self.newsData!.articles!)
//
//                }
              

               
//                    print("===>: \(String(describing: self.newsData?.articles))")

                

                
            case .failure( _):
                print("Error: \(String(describing: response.result.error))")
            }
        }
        
    }
    
    
    
    
    func setupSlideScrollView(news : [Article]) {
         DispatchQueue.main.async {
            self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(news.count), height: self.view.frame.height)
            self.scrollView.isPagingEnabled = true

        for i in 0 ..< news.count {
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.05, alpha:1.0)
            slide.headerImage.sd_setImage(with: URL(string:news[i].urlToImage! ), placeholderImage: UIImage(named: "placeholder.png"))
                         slide.titleLabel.text = news[i].title
            slide.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            slide.dateLabel.text =  news[i].publishedAt!
            slide.sourceLabel.text =  news[i].source?.name
            slide.titleLabel.sizeToFit()

            
            slide.frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.scrollView.addSubview(slide)
        }
        }
    }
    
    
    
    
}
