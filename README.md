# Tymofieiv_Headway_Test
This APP shows how to use fetched audiobooks data to play audio, switch core player functions and taking advantage of TCA architecture.

Techical tasks:
1. SwiftUI
2. Swift Concurrency
3. TCA
4. Player features:
- a) Play/pause
- b) Switching between different parts of the summary (eg sections/chapters/keyPoints).
- c) Adjusting the playback speed.
- d) Fast forward/rewind the audio for a certain amount of time.

## Tech task 1
All code is written in SwiftUI. I used Swift Package Manager to import Composable Architecture for importing modeules. For the simplicity and convinces of test App for the technician interview, I decided not to bloat code, separate file structures. 

## Tech task 2
As I haven't had a good solution for implementating API request to load and save book data, I decided just to have audio files and pictures already installed. Nevertheless, to use these files I've always write asynchrony’s functions to fetch data for URL, have await modifiers. UI has some ProgressView for showing while App recieves data from bundle.
Also, using Composable Architecture you can't have asynchrony’s code for Actions anywhere but in Effect closure. So all time sensitive task, coupled actions are done through .run modifier in 'return Effect'.

## Tech task 2
For convince I implemented all TCA structure inside single file, making it a Feature. App has a Store, Reducer, State and Action's to make this architecture communicate with data in real time changing UI and making simple testable environment. 

## Tech tasks 4 (a, b, d)
https://github.com/user-attachments/assets/802089dd-e6e6-4e48-9dae-4a8b18a037dc

## Tech tasks 4 (c) and *additional features
https://github.com/user-attachments/assets/7a765779-ce37-4c1e-aad1-60e879ea1042

- slider shows timepoint at current time, while scrolling;
- after ending current keyPoint, if it's not a last one, it's automatically runs next;
- on skipping to next/previous keyPoint audio will play automatically if 'play' was turned on;
- every keyPoint has text summary 'hidden' behind book cover by toggling bottom switch;

