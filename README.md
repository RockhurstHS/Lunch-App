# Lunch-App
Pulls data from http://myschooldining.com/ using an HTTP POST request

## How does it work?
The MySchoolDining web site uses an HTTP POST request and reponse to get the menu data and populate a table. The Lunch-App sends and HTTP POST request to the server and receives an HTML response.

## iOS App
* Uses the Alamofire Framework the http request
* Uses the Kanna Framework to parse the HTML response
* Requires iOS 8.0 and up

## Android App
* Native HTTP POST request
* Gets response and displays it in a webview
* Relies on an external style sheet