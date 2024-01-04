//
//  SuperView.swift
//  NFGGalleryApp
//
//  Created by Mohammad Abdellahi (Speed4Trade GmbH) on 03.01.24.
// SuperUIView : implement public function like toast , navigate ...

import UIKit

class SuperUIView: UIViewController {

    // MARK: - public Functions
    func showToast(message: String, type: Enumerates.ToastColor, lines: Int) {
        var toastLabel = UILabel()
        DispatchQueue.main.async {
            if lines > 8 {
                toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 175,
                                                   y: self.view.frame.size.height - 300,
                                                   width: 350,
                                                   height: CGFloat(20 * lines)))
            } else if lines > 6 {
                toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 175,
                                                   y: self.view.frame.size.height - 250,
                                                   width: 350,
                                                   height: CGFloat(20 * lines)))
            } else if lines > 3 {
                toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 175,
                                                   y: self.view.frame.size.height - 200,
                                                   width: 350,
                                                   height: CGFloat(20 * lines)))
            } else {
                toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 175,
                                                   y: self.view.frame.size.height - 150,
                                                   width: 350,
                                                   height: CGFloat(35 * lines)))
            }

            toastLabel.font = .systemFont(ofSize: 15)
            toastLabel.textAlignment = .center
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.numberOfLines = lines
            toastLabel.clipsToBounds = true
            toastLabel.textColor = UIColor.white
            switch type {
            case Enumerates.ToastColor.success:
                toastLabel.backgroundColor = UIColor.green
            case Enumerates.ToastColor.error:
                toastLabel.backgroundColor = UIColor.red
            case Enumerates.ToastColor.warning:
                toastLabel.backgroundColor = UIColor.orange
            }
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 2.0, delay: 1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    }

    func getStoryboard() -> UIStoryboard {
        return UIStoryboard(name: ViewControllers.STORYBOARD, bundle: nil)
    }

    func instantiateViewController(_ viewControllerIdentifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: ViewControllers.STORYBOARD, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: viewControllerIdentifier)
    }

    func navigateTo(_ viewControllerIdentifier: String) {
        let nextViewController = instantiateViewController(viewControllerIdentifier)
        navigateTo(nextViewController)
    }

    func navigateTo(_ viewController: UIViewController) {
        view.endEditing(true)

        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical

        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.present(viewController, animated: false, completion: nil)
        }
    }

}
