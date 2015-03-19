# Introduction #

This contains methods for doing different tasks with xcode

# Details #

Referencing an object to a visible object on the Interface.
1.On the AppNameViewController.h file, create the new object that will reference the Interface object by writing.
IBOutlet UILabel `*newLabel`;
NOTE: you may have to change UILabel depending on the object you are trying to reference, for example UIView or UIButton. Also, "newLabel" will be the name of the object you created.
2.Double click the AppNameViewController.xib file to open the Interface Builder.
3.Here you must select the object you are going to reference and then right-click it.
NOTE: make sure that the object is highlighted before right-clicking or you may end up referencing the view window, and not the object you want.
4.After right-clicking, click on circle to the right of **New Referencing Outlet** and drag it on top of **File's Owner** in the AppNameViewController.xib.
NOTE: if an interface object is already referenced to an INBoutlet, you must delete the old reference before dragging the circle.
5.Then you may have a list of IBOutlets to choose from, so select newLabel.
6.Now you can call that object through your code anywhere inside AppNameViewController.m, for example you could write:
[setHidden:TRUE](newLabel.md);
to hide the label that was referenced


Showing a view other than the main view in the same xib
1.Create a new view in the Interface Builder by dragging it from the library of objects
NOTE: this is only for views not views with view controllers
2.Reference the new view to a new object using UIView, for example:
IBOutlet UIView **newView;
4.On your AppNameViewController.m file, now you can write:
[self.view addSubview:newView];
5.Then when that part of the code is performed the newView pops up on top of the main view**

Hiding a view that was displayed using **addSubview**
1.If you used:
[self.view addSubview:newView];
now you can use
[removeFromSuperview](newView.md);
to hide the view and display the main window.

Changing the text of a button during runtime
1.Reference the button to a new object using UIButton, for example:
IBOutlet UIButton **theButton;
2.On your AppNameViewController.m file, now you can write:
[setTitle:@"The new title here" forState:0](theButton.md);
NOTE: you must have forState in the function, it actually refers to the different states that the button can have, for example**Dfault State**,**Highlighted State**,**Selected State**,**Disabled State**.**

Changing the picture of an image view during run time
1.Reference the button to a new object using UIImageView, for example:
IBOutlet UIImageView **imageView;
2.On your AppNameViewController.h file, now you can write:
imageView.image = [imageNamed:@"and the name of the picture.png"](UIImage.md);**

Showing an alert message on the screen
1.Write this line in your code:
[[[alloc](UIAlertView.md) initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Self Explanatory" otherButtonTitles:nil] show];
2.Change the text fields, and then when that line is read, an alert window will pop up

Creating a new button during runtime
NOTE:All the following code should be writen in the same function
1.Create button:
newButton = [buttonWithType:UIButtonTypeRoundedRect](UIButton.md);
2.Set the button Location and size (x,y,w,h):
newButton.frame = CGRectMake(100,170,100,30);
3.Set the title of the button:
[setTitle:@"New" forState:UIControlStateNormal](newButton.md);
NOTE: UIControllStateNormal is the same a writing 0
4.Set the fuction that the button will call when pessed:
[addTarget:self action:@selector(NewButtonPressed:) forControlEvents:UIControlEventTouchUpInside](newButton.md);
5.Show the button in the main view as a subview:
[self.view addSubview:newButton];
6.If you want functionality for your button, you can write a new function:
-(IBAction)NewButtonPressed:(id)sender{}
NOTE: The name of the function must be the same in steps 6 and 4

Using an array
1.To create the array, on AppNameController.m write:
NSArray **newArray = [arrayWithObjects: @"Object 1", @"Object 2", @"Object 3", @"Object 4",nil](NSArray.md);
2.To use the array, on AppNameController.m write:
[objectAtIndex:2](newArray.md);
NOTE: the string that the array outputs, depends on the Integer given, from 0 to 3 in this case**

# Summary #
|Referencing|IBOutlet UILabel **newLabel;**|
|:----------|:----------------|
|Hiding/UnHiding|[setHidden:TRUE](newLabel.md);|
|ShwingAView|[self.view addSubview:newView];|
|RemovingAView|[removeFromSuperview](newView.md);|
|SetingButtonText|[setTitle:@"The new title here" forState:0](theButton.md);|
|ChangingImage|imageView.image = [imageNamed:@"and the name of the picture.png"](UIImage.md);|
|PopUpAlert|[[[alloc](UIAlertView.md) initWithTitle:@"Title" message:@"Message" delegate:nil cancelButtonTitle:@"Self Explanatory" otherButtonTitles:nil] show];|
|UsingAnArray|[objectAtIndex:2](newArray.md);|
|MakeButton|newButton = [buttonWithType:UIButtonTypeRoundedRect](UIButton.md);|
|MakeButton|newButton.frame = CGRectMake(100,170,100,30);|
|MakeButton|[setTitle:@"New" forState:UIControlStateNormal](newButton.md);|
|MakeButton|[addTarget:self action:@selector(NewButtonPressed:) forControlEvents:UIControlEventTouchUpInside](newButton.md);|
|MakeButton|[self.view addSubview:newButton];|



Add your content here.  Format your content with:
  * Text in **bold** or _italic_
  * Headings, paragraphs, and lists
  * Automatic links to other wiki pages