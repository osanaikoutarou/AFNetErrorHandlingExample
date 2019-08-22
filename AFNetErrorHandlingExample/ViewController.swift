//
//  ViewController.swift
//  AFNetErrorHandlingExample
//
//  Created by osanai on 2019/08/22.
//  Copyright © 2019 osanai. All rights reserved.
//

import AFNetworking
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("**************** start ********************")
        let m = AFHTTPSessionManager()
        m.get("http://localhost:3000/usersaaaa", parameters: [], progress: nil,
              success: { (urlsessionDataTask: URLSessionDataTask, response: Any?) in
                print("success :" + response.debugDescription )
        }) { (urlsessionDataTask: URLSessionDataTask?, error: Error) in
            print("failure :" + error.localizedDescription)
            print("----")
            print(error.failingResponseDictionary() ?? "ないです")
        }
    }

}

private extension Error {
    func failingResponseDictionary() -> [String: Any]? {
        if let userInfo = self._userInfo as? [String: Any] {
            if let failingUrlResponseDataError = userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data {
                var buf: Any = ""
                do {
                    buf = try JSONSerialization.jsonObject(with: failingUrlResponseDataError, options: JSONSerialization.ReadingOptions.allowFragments)
                } catch {
                    print(error)
                }

                if let dic = buf as? [String: Any] {
                    return dic
                }
            }
        }
        return nil
    }
}
