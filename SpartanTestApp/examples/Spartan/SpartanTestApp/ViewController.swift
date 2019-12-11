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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // turns debugging off for making the network calls using Spartan
        Spartan.loggingEnabled = false
        
        SpotifyLogin.shared.getAccessToken { [weak self] (token, error) in
            self?.loggedInStackView.alpha = (error == nil) ? 1.0 : 0.0
            if error != nil, token == nil {
                self?.showLoginFlow()
            } else {
                
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
            var trackIds: [String] = []
            for track in tracks {
                trackIds.append(track.id as! String)
            }
            print(trackIds)
            _ = Spartan.getAudioFeatures(trackIds: trackIds, success: { (audioFeaturesObject) in
                for audioFeatures in audioFeaturesObject {
                    print(audioFeatures.energy)
                }
            }, failure: { (error) in
                print(error)
            })
        }, failure: { (error) in
            print(error)
        })
    }
    
    // this function creates a new, empty playlist and alerts you when the action is complete
    @IBAction func didTapCreateNewPlaylist(_ sender: Any) {
        let userId = SpotifyLogin.shared.username!
        let name = "New Playlist"
        _ = Spartan.createPlaylist(userId: userId, name: name, isPublic: true, isCollaborative: false, success: { (playlist) in
            
            let alert = UIAlertController(title: "You've created a new playlist named: \n" + name, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in}))
            self.present(alert, animated: true)
            
        }, failure: { (error) in
            print(error)
        })
    }
    
    // When the "Create Playlist for the Office" button is pressed, this function runs"
    @IBAction func createCalmPlaylist(_ sender: Any) {
        generatePlaylist(playlistName: "Calm, Office Music", numSongs: 15, results: ["Calm", "Office"])
    }
    
    // When the "Create Playlist for the Party" button is pressed, this function runs"
    @IBAction func createPartyPlaylist(_ sender: Any) {
        generatePlaylist(playlistName: "Let's Get Rowdy!", numSongs: 30, results: ["Party", "Loud", ">10"])
    }
    
    // When the "Create Playlist for the Bedroom" button is pressed, this function runs"
    @IBAction func createBedroomPlaylist(_ sender: Any) {
        generatePlaylist(playlistName: "Bedroom and Chill", numSongs: 10, results: ["Bedroom", "Calm"])
    }
    
    // this function generates a playlist through the spotify api based off of results fed
    // through an array of strings denoting the parameters you want the playlist to be based
    // off of
    func generatePlaylist(playlistName: String, numSongs: Int, results: [String]) {
        let multiplier = getMultiplierFromSurveyResults(surveyResults: results)
        let userId = SpotifyLogin.shared.username!
        var fitnessTracks = [TrackWithFitness]()
        
        // retrieve songs
         _ = Spartan.getSavedTracks(limit: 50, offset: 0, market: .us, success: { (pagingObject) in
            var trackIds: [String] = []
            for track in pagingObject.items {
                trackIds.append(track.track.id as! String)
            }
            
            // filter them
            _ = Spartan.getAudioFeatures(trackIds: trackIds, success: { (audioFeaturesObject) in
                for audioFeatures in audioFeaturesObject {
                    let track = TrackWithFitness(track: audioFeatures)
                    fitnessTracks.append(track)
                    track.calculateFitness(multipliers: multiplier)
                }
                
                fitnessTracks.sort(by: >)
                var newTrackUris = [String]()
                print("\nPost-sorted Tracks: ")
                for i in 0..<min(numSongs, pagingObject.items.count) {
                    newTrackUris.append(fitnessTracks[i].track.uri!)
                }
                
                // create the new playlist
                _ = Spartan.createPlaylist(userId: userId, name: playlistName, isPublic: true, isCollaborative: false, success: { (playlist) in
                    
                    // add filtered tracks to the new playlist
                    _ = Spartan.addTracksToPlaylist(userId: userId, playlistId: playlist.id as! String, trackUris: newTrackUris, success: { (snapshot) in
                        // Do something with the snapshot
                    }, failure: { (error) in
                        print(error)
                    })
                }, failure: { (error) in
                    print(error)
                })
                
            }, failure: { (error) in
                print(error)
            })
            
        }, failure: { (error) in
            print(error)
        })
        
    }

}
