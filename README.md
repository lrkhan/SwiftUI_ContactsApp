# ContactMe (SwiftUI Contacts App)

ContactMe is an app that lets the user create, edit, view, and delete contacts. 
The user creates a new contact with name, number, email, and profile picture.

The app is an example of a simple CRUD (Create, Read, Update, Delete) appliaiton.

The contacts are stored as a single JSON object in the app's document directory. Additionally, the contact images are saved with the contact's unique ID in the same directory.

Feel Free to Check Out the Code!

## ScreenShots

<img src="./Images/mainSearch.png" width="250" alt="Search Bar for Contacts" class="center">
<img src="./Images/contactSearch.png" width="250" alt="Contact Search" class="center">



### Main Screen - Blank
<img src="./Images/mainBlank.png" width="250" alt="Main Screen Blank Image" class="center">

When the user first opens the app they are greated with a blank screen with an "Add Person" button.

### Adding a Contact
<<img src="./Images/addNew.png" width="250" alt="Add New Contact Sheet" class="center">

Clicking on the "Add Person" button brings up the add new contact sheet. The user can fill in the contacts' name, email, phone number, and a potential profile picture.

A filled out new contact may look like the following (without a contact image):

<img src="./Images/addNewFilled.png" width="250" alt="Add New Contact Sheet - Filled" class="center">

The user can click on the large "Person" icon and it will launch the image picker:

<img src="./Images/contactImg.png" width="250" alt="Image Picker" class="center">

The user can select an image from their photo library (after granting permission) and the new contact sheet should look like the following.

<img src="./Images/addNewWPic.png" width="250" alt="Add New Contact Sheet - Filled with Contact Image" class="center">


### Main Screen - With User(s)
<img src="./Images/mainOne.png" width="250" alt="Main Screen with Single User" class="center">

The main screen with a single contacts. 

<img src="./Images/mainFilled.png" width="250" alt="Main Screen Image" class="center">

The main screen with multiple contacts.

### Viewing a Contact
<img src="./Images/contactInfo.png" width="250" alt="Contact Info Page" class="center">

Clicking on a Contact will Bring up their page with the information that the user put in.

<img src="./Images/contactEdit.png" width="250" alt="Editing The Contact" class="center">

The user can click the "Edit" button and change any relevent information.

<img src="./Images/contactChange.png" width="250" alt="Changed Contact" class="center">

The information that the user updates changes and gets saved fro that contact.

### Deleting a Contact
<img src="./Images/swipeToDelete.png" width="250" alt="Main Screen Image" class="center">

Swiping from left to right on an contact on the main screen will bring up the ability to delete a contact.

### Rolling For An Option
<img src="./Images/mainSearch.png" width="250" alt="Search Bar for Contacts" class="center">

Pulling down from the top reveals the search function of the app. 

<img src="./Images/contactSearch.png" width="250" alt="Contact Search" class="center">

Users can then enter text that parses the contants first or last names to find any matches.
