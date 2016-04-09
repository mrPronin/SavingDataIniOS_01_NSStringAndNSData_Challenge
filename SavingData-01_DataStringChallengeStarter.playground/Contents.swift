
import UIKit
//: ## Saving Data in iOS: Challenge 1 - Strings and NSData
//:
//: Saving data in iOS is critical for making apps that persist. There are lots of ways to save data but the most basic approach involves calling methods on Strings and NSData
//:
//: This challenge is twofold. First, you will save a string to the document directory, and then read it back to the console. Next, you will also save an image to the document directory and also read it back.
//:
//: ----
//:
//: ### Part One: Writing and Reading a String
//: The first step is to create a string. Add a new string underneath this line:
let myString = "My favorite test string"
//: With your string in place, you need to get a reference to the filemanager. In the next line, get this reference by calling defaultManager() on the NSFileManager object.
let fileManager = NSFileManager.defaultManager()
//: Reading and writing is prone to errors. For instance, a disk may be full or it may be damaged. Whenever you do any reading or writing to a disk, you make sure you put it in a do-catch block. In this case, the do-catch block has been created for you.
do {
    

//: The first thing you need to do is get a NSURL to document directory. You can do this by calling URLForDirectory on your FileManager object. Make sure to set the inDomain to UserDomainMask. Also, appropriateForURL should be nil and create should be set to false.
    let documents = try fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
//: Now that you have your URL to your document directory, you need a url to the file you are saving. Saving from a string will create a text file. You need to add the text file name to the baseUrl that you just created. You can do this by calling URLByAppendingPathComponent. Pass in the file name (such as "mystring.txt") and save this reference to another variable.
    let url = documents.URLByAppendingPathComponent("mystring.txt")
//: At this point, you can write your string to disk. Call the writeToURL method on your string, and pass in the url that you created in the previous step. Set atomically to true and make sure the encoding is NSUTF8StringEncoding.
    try myString.writeToURL(url, atomically: true, encoding: NSUTF8StringEncoding)
//: Now, load the contents of the file into another string. Create a new String object by calling the contentsOfURL initializer. Make sure to pass in the url for your saved file.
    let newString = try String(contentsOfURL: url)
//: Finally print out your string to the console.
    print("string: \(newString)")
//: Congrats! You saved and read a new string!
} catch {
  print(error)
}

//:
//: ----
//:
//: ### Part Two: Writing and Reading NSData
//: Often times you'll be saving objects to NSData and then saving that NSData to disk. Thankfully, doing this is really easy.
//:
//: In this challenge, I've provided an image for you to use that is included with the playground. This image was created by Joe Lercio which you can find over here: http://vector4free.com/vector/blue-monster///: Or you can provide your own image. If you want to use your own image, simply take your image and drag it into the Resources folder of the playground.
//:
//: You'll be reading an image from the playground, saving it to disk, then reading it back from the disk.
//:
//: Since you'll be reading and writing to disk, all the code will be placed within a do-catch block. I've already set it up for you.
do {
//: The first thing you need to do is to create a URL for where you are saving the image. Call the filename: moster.png. Note, if you forget how to get the URL for a directory and how to append a filename, check the first part of this challenge.
    let documents = try fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
    let url = documents.URLByAppendingPathComponent("monster.png")
//: Now that you have your image URL of where you are saving it to disk, you need to first load it from the playground itself.
    let monsterImage = UIImage(named: "monster.png")
//: Convert this image to NSData by calling the function UIImagePNGRepresentation.
    let imageData = UIImagePNGRepresentation(monsterImage!)
//: Finally write ths data to disk by calling the writeToURL method on your data. Set atomically to true.
    imageData?.writeToURL(url, atomically: true)
//: With your data written to disk, creata a new variable. This variable will hold the data read from disk. Create a NSData using the initializer contentsOfURL.
    let newData = NSData(contentsOfURL: url)
//: Finally, create a new UIImage, passing in the data to the data initializer. If you created everything correctly, you'll be able to preview it in the playground.
    let newImage = UIImage(data: newData!)
    
} catch {
  print(error)
}

