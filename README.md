
# TunesBay

An iOS Music App Created on UIKit with Swift.



## Tech Stack

**Tech:** UIKit, Swift



## Features

- Music Search
- Download Music Locally
- Mark tracks as favourites
- Cache the track info
- Get the price of the album record
- Get the date of release


## API Reference

#### Get search tracks/artists/albums

```http
  GET var url : String = "https://itunes.apple.com/search?term="searchItem"
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `searchItem`      | `string` | **Required**. Search song name or artist Name |

#### Get track

```http
  GET https://itunes.apple.com/lookup?id=\(trackID)
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `trackID` | `string` | **Required**. Returns all the details of a particular track |







## Screenshots

![App Screenshot](https://raw.githubusercontent.com/AdityaGautam05/TunesBay/Version-1/Screenshots/Screenshot-1.png)

![App Screenshot](https://raw.githubusercontent.com/AdityaGautam05/TunesBay/Version-1/Screenshots/Screenshot-4.png)

![App Screenshot](https://raw.githubusercontent.com/AdityaGautam05/TunesBay/Version-1/Screenshots/Screenshot-5.png)

![App Screenshot](https://raw.githubusercontent.com/AdityaGautam05/TunesBay/Version-1/Screenshots/Screenshot-3.png)
