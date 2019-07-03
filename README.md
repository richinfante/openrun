# openrun (iOS)
A private run tracking app - no telemetry, web services, or sharing.

## Primary Goals of this project
- [x] Capture Run / Walk / Cycling session pace, time, gps tracks
  - [x] pace calculation
  - [x] timer
  - [x] distance
  - [ ] store gps tracks
  - [ ] elevation stats
  - [x] voice feedback
- [ ] List history of exercise sessions (deletable)
- [ ] iOS Health sync (optional)
- [x] Privacy first - no sensitive information transmitted (ever!)

## Additional features which may be cool
- Full export of run history + tracks
- Trail mapping for hiking
- Web Service Hooks - allow you to perform automatic sync with custom services (by configuring urls manually in-app)

## "WONTFIX"
- Spotify support is *NOT PLANNED*. This requires bundling their framework into the app.
  - This may be revisited if playback control becomes possible under a similar API as the music app, or [this API](https://developer.spotify.com/documentation/web-api/reference/player/skip-users-playback-to-next-track/) (currently in beta) allows us to preform the required actions.
  
