# ResistorGuide App
![ResistorGuide_Banner](Screenshots/ResistorGuide-feature-graphic.png)

 ### An app that calculates resistor combinations and color codes.
 
 
 This app was created using the Flutter Framework in the Dart language
 
 Download it on the Google Play Store: 
 
 [<img src="Screenshots/google-play-badge.png" width="300">](https://play.google.com/store/apps/details?id=moustafaeid.resistorguide)

 
 <table>
  <tr>
    <td>  <img src="https://cdn.worldvectorlogo.com/logos/flutter-logo.svg" width="100"></td>
    <td><img src="https://cdn.freebiesupply.com/logos/large/2x/dart-logo-png-transparent.png" width="130"></td>
  </tr>
 </table>

# Demo:

<p align="center">
  <img align="center" src="Screenshots/Demo.gif" width="300">
</p>

# Functionality:

### Color Code to Resistance Calculator 


We've all ran in to those situations where you're in a lab and time is limited but you are stuck going through your lab kit, trying to figure out which resistor is which? 

Fortunately the first function of my app is a Color Code to Resistance Calculator.

Enter the number of bands and color of each band, The app will calculate the resistance and tolerance of the resistor and output it.

<p align="center">
  <img align="center" src="Screenshots/Screenshot_20200501-195111.jpg" width="300"> <img align="center" src="Screenshots/ColortoResGif.gif" width="300">
</p>

This was used as a reference for the calculations:

<p align="center">
  <img src="https://www.hobby-hour.com/electronics/resistorcolorcode.gif">
</p>

### Resistor Combinations and Color Code Calculator


One of the most important aspects when designing circuits is picking the right resistance for your needs. Unfortunately, most of the time after doing your calculations, you find that the resistance you need is not a standard value.

This app attempts to help with this issue by allowing the user to input any resistance they desire and tolerance details, the app will then calculate all the single, series and parallel combinations of 2 resistors in the standard set that will equal to the desired resistance (Within 2.5% Error).

The app displays these combinations in a list that when tapped, will show the color codes of both resistors.

<p align="center">
  <img align="center" src="Screenshots/Screenshot_20200501-195141.jpg" width="300"> <img align="center" src="Screenshots/Screenshot_20200501-195205.jpg" width="300"> 
</p>

<p align="center">
 <img align="center" src="Screenshots/Screenshot_20200501-195218.jpg" width="300"> <img align="center" src="Screenshots/RestoColorGif.gif" width="300">
</p>


The method of calculation for this function of the app was inspired by Claudio Girardi's Resistor Calculator found here:

https://www.qsl.net/in3otd/parallr.html

# Usage:

To edit and run this app, you will need a flutter compatible IDE.


First create a flutter project


Then replace these files with the ones in this github repo
* /lib
* /images
* /Sets
* /icons
* pubspec.yaml
* pubsec.lock

Then save and run and that is all you need to edit this code
