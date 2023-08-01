//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Мявкo on 25.07.23.
//


import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.loadGif(name: "Stars")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    lazy var ballImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ball")
        return imageView
    }()
    
    lazy var triangleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "triangle")
        return imageView
    }()
    
    let predictions = ["Yes",
                       "No",
                       "Probably",
                       "Without a doubt",
                       "Definitely",
                       "Don't count on it",
                       "Very doubtful",
                       "Ask again later"]
    
    lazy var predictionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.5)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var rollButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find out", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addTarget(self, action: #selector(rollButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    var answer: String?
    
    @objc func rollButtonTapped(_ sender: UIButton) {
        
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 1.0
        shakeAnimation.values = [-10, 10, -10, 10, -5, 5, -5, 5, 0]
        ballImageView.layer.add(shakeAnimation, forKey: "shake")
        
        UIView.animate(withDuration: 0.1, animations: {
            self.predictionLabel.alpha = 0.0
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.answer = self.predictions.randomElement()
            self.predictionLabel.alpha = 1.0
            self.predictionLabel.text = self.answer
            
            var space: Int
            if (self.answer?.count)! <= 10 {
                space = 35
            } else {
                space = 25
            }
            self.predictionLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(space)
            }
        }
    }
    
    func layout() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.height.equalTo(115)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        triangleImageView.addSubview(predictionLabel)
        predictionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.width.equalTo(60)
            make.centerX.equalToSuperview()
        }
        
        ballImageView.addSubview(triangleImageView)
        triangleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(88)
            make.height.width.width.equalTo(120)
        }
        
        view.addSubview(ballImageView)
        ballImageView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(130)
            make.centerX.equalToSuperview()
            make.height.width.width.equalTo(260)
        }
        
        view.addSubview(rollButton)
        rollButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ballImageView.snp.bottom).offset(120)
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
    }
}

