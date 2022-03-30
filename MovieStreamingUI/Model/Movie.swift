//
//  Movie.swift
//  MovieStreamingUI
//
//  Created by Shameem Reza on 30/3/22.
//

import SwiftUI

// MARK: - MOVIE DATA MODEL

struct Movie: Identifiable {
    var id = UUID().uuidString
    var movieTitle: String
    var movieThumb: String
    var movieStory: String
}

// MARK: - MOVIE DATA

var movies: [Movie] = [
    Movie(movieTitle: "Death on the Nile", movieThumb: "m1", movieStory: "Belgian sleuth Hercule Poirot's vacation aboard a glamorous river steamer turns into a terrifying search for a murderer when a picture-perfect couple's idyllic honeymoon is tragically cut short. Set against an epic landscape of sweeping Egyptian desert vistas and the majestic Giza pyramids, this tale of unbridled passion and incapacitating jealousy features a cosmopolitan group of impeccably dressed travelers, and enough wicked twists and turns to leave audiences guessing until the final, shocking denouement."),
    Movie(movieTitle: "Pushpa: The Rise", movieThumb: "m2", movieStory: "Pushpa a labor works for small sum but dreams of living a life of king. But he is always let down by his step brothers for being an illegitimate child of their father. He gets chance to work in dense forest of red sanders where red sanders are smuggled to other countries. The labors are always under the scanner of DSP Govindappa but Pushpa dares to go against everyone creating hurdles for DSP. Pushpa manages to save a smuggling consignment worth crores under the eye of DSP and becomes known to Reddy Brothers. (Konda Reddy, Jakka Reddy and Jolly Reddy) known to do smuggling of red sanders. Pushpa manages to smuggle red sanders often with his tricks by bluffing DSP and his team and becomes close side of Konda Reddy. Pushpa changes his lifestyle and decides to marry Srivelli but his step brothers disclose his mother's relationship with their father thus calling of the marriage. Pushpa who now decides not to stop in reaching heights and finds that Mangalam Sinu, a syndicate member is giving Reddy's gang much lesser share than they deserve and asks Konda Reddy to hike profit. Konda Reddy asks Pushpa to take thing sin his hands as his involvement will lead to war between the two gangs.A fearless Pushpa decides to take control of things leading to disagreements between two gangs."),
    Movie(movieTitle: "James", movieThumb: "m3", movieStory: "James also called Santhosh Kumar, who works as a manager in a security company and finds himself up against the big bad guys."),
    Movie(movieTitle: "Checkered Ninja 2", movieThumb: "m4", movieStory: "Follow Alex and the Checkered Ninja who embark on a frantic hunt for the villain Phillip Eppermint, who has evaded a prison sentence in Thailand."),
    Movie(movieTitle: "Deep Water", movieThumb: "m5", movieStory: "Vic and Melinda Van Allen are a couple in the small town of Little Wesley. Their loveless marriage is held together only by a precarious arrangement whereby, in order to avoid the messiness of divorce, Melinda is allowed to take any number of lovers as long as she does not desert her family. Vic becomes fascinated with the unsolved murder of one of Melinda's former lovers, Martin McRae, and, in order to successfully drive away her current fling, takes credit for the killing. When the real murderer is apprehended, Vic's claims are interpreted by the community as dark jokes."),
    Movie(movieTitle: "Deadlock", movieThumb: "m6", movieStory: "Ron Whitlock is a wanted criminal leading a team of mercenaries on a mission of vengeance. Convinced that the government is working against them, the merciless group brutally seizes an energy plant and holds everyone inside hostage. With a nearby town on the brink of massive flooding and destruction, it's up to one retired elite army ranger Mack Karr to save thousands of innocent lives before it's too late."),
    Movie(movieTitle: "The Batman", movieThumb: "m7", movieStory: "When the Riddler, a sadistic serial killer, begins murdering key political figures in Gotham, Batman is forced to investigate the city's hidden corruption and question his family's involvement."),
    Movie(movieTitle: "Restless", movieThumb: "m8", movieStory: "After going to extremes to cover up an accident, a corrupt cop's life spirals out of control when he starts receiving threats from a mysterious witness."),
]
