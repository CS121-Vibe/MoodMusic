// Copyright (c) 2017 Spotify AB.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import SpotifyLogin
import Spartan

class ViewController: UIViewController {

    @IBOutlet weak var loggedInStackView: UIStackView!
    @IBOutlet weak var newPlaylistName: UITextField!
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // turns debugging on for making the network calls using Spartan
        Spartan.loggingEnabled = true
        
        SpotifyLogin.shared.getAccessToken { [weak self] (token, error) in
            self?.loggedInStackView.alpha = (error == nil) ? 1.0 : 0.0
            if error != nil, token == nil {
                self?.showLoginFlow()
            } else {
                print(SpotifyLogin.shared.username)
                
                // sets the auth token so that spotify can make all the requests
                Spartan.authorizationToken = token
            }
        }
    }

    func showLoginFlow() {
        self.performSegue(withIdentifier: "home_to_login", sender: self)
    }

    @IBAction func didTapLogOut(_ sender: Any) {
        SpotifyLogin.shared.logout()
        self.loggedInStackView.alpha = 0.0
        self.showLoginFlow()
    }
    
    // this function gets Frank Ocean's top tracks and prints them out in the console
    @IBAction func didTapFrankOceanTracks(_ sender: Any) {
        _ = Spartan.getArtistsTopTracks(artistId: "2h93pZq0e7k5yf4dywlkpM", country: .us, success: { (tracks) in
            print(tracks)
        }, failure: { (error) in
            print(error)
        })
    }
    
    // this function creates a new playlist
    @IBAction func didTapCreateNewPlaylist(_ sender: Any) {
        let userId = SpotifyLogin.shared.username!
        let name = newPlaylistName.text ?? "New Playlist"
        _ = Spartan.createPlaylist(userId: userId, name: name, isPublic: true, isCollaborative: false, success: { (playlist) in
            
            let alert = UIAlertController(title: "You've created a new playlist named: \n" + name, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in}))
            self.present(alert, animated: true)
            
        }, failure: { (error) in
            print(error)
        })
    }
}

// Frank Ocean:
// https://open.spotify.com/artist/2h93pZq0e7k5yf4dywlkpM?si=OaxmN3xEQ8yLoftQL66aGA
