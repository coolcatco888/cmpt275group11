## Intro ##

A walkthrough for using textfields and the keyboard, and how to get the screen to scroll up with the keyboard. Also get labels to show what was just typed.


### How To ###

**1. Creating the textfield**<br>
First, open the viewcontroller.xib file in interface builder. Drag a textfield from the library into the view. Then open the viewcontroller.h file, and declare your textfield: type in <code>IBOutlet UITextField *textField;</code> (where "textField" is the name and can be anything you want,) after <code>UIViewController{</code>. Then, declare your accessors by typing <code>@property (nonatomic, retain) UITextField *textField;</code> after <code> } </code>and before <code>@end</code>. Next, implement your accessors by going to the viewcontroller.m file and typing in <code>@synthesize textField;</code>. Finally, find the <code>-(void)dealloc</code> method and add <code>[textField release];</code> to it, above <code>[super dealloc];</code>.<br>
<br> If you want to add the label, do the same thing, just change textfield to label, and <code>UITextField</code> to <code>UILabel</code>.<br>
<br><br><br>
<b>2. Connecting it up in Interface Builder</b><br>
Go back to viewcontroller.xib in interface builder. Right-click File's Owner, and look for the little circle next to textField, under Outlets. Click and drag that circle to the textfield you want in the view. It should now appear next to the circle, and if you hover over it, the selected textfield in the view should highlight. Do the same for the label if you have it.<br>
<br><br><br>
<b>3. Recognizing when the keyboard will appear</b><br>
First, we need to register to be notified by the <code>NSNotificationCenter</code> model class when the keyboard will show up. We do that by adding the following method to viewcontroller.m:<br>
<pre><code>- (void)viewWillAppear:(BOOL)animated {<br>
   [[NSNotificationCenter defaultCenter] <br>
      addObserver:self<br>
      selector:@selector(keyboardWillShow:)<br>
      name:UIKeyboardWillShowNotification<br>
      object:self.view.window];<br>
<br>
   [super viewWillAppear:animated];<br>
}<br>
</code></pre>
We also need to unregister when the view is released. We do this by adding the following method (right underneath the previous one, to keep things organized):<br>
<pre><code>- (void)viewWillDisappear:(BOOL)animated {<br>
   [[NSNotificationCenter defaultCenter]<br>
      removeObserver:self<br>
      name:UIKeyboardWillShowNotification<br>
      object:nil];<br>
<br>
   [super viewWillDisappear:animated];<br>
}<br>
</code></pre>
What we are doing when we write these methods is actually overriding the methods from the superclass. What we write is basically the same, we just added some code that will register us with NSNotificationCenter.<br>
<br><br><br>
<b>4. Deciding when to scroll, and by how much</b><br>
Type in the following method after <code>viewWillDisappear</code>:<br>
<pre><code>- (void)keyboardWillShow:(NSNotification *)notif {<br>
<br>
   NSDictionary* info = [notif userInfo];<br>
   NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];<br>
   CGSize keyboardSize = [aValue CGRectValue].size;<br>
   float bottomPoint = (textField.frame.origin.y + textField.frame.size.height + 10);<br>
   scrollAmount = keyboardSize.height - (self.view.frame.size.height - bottomPoint);<br>
<br>
   if (scrollAmount &gt; 0) {<br>
      moveViewUp = YES;<br>
      [self scrollTheView: YES];<br>
   }else<br>
      moveViewUp = NO;<br>
}<br>
</code></pre>
This method finds the height of the keyboard and the textframe, and decides how much to scroll based on these, as well as the location of the textfield. It checks to see if the view should be moved up, and acts accordingly.<br>
<br><br><br>
<b>5. Scrolling the view</b><br>
You may have noticed a method in the last method called <code>scrollTheView</code>. Well, this isn't included, and we must implement it ourselves. To do that we use the animation features built in to the view.<br>
<pre><code>- (void)scrollTheView:(BOOL)movedUp {<br>
<br>
   [UIView beginAnimations:nil context:NULL];<br>
   [UIView setAnimationDuration:0.3];<br>
   CGRect rect = self.view.frame;<br>
   if(movedUp) {<br>
      rect.origin.y -= scrollAmount;<br>
   }else {<br>
      rect.origin.y += scrollAmount;<br>
   }<br>
   self.view.frame = rect;<br>
   [UIView commitAnimations];<br>
}<br>
</code></pre>
<br><br><br>
<b>6. Updating viewcontroller.h</b><br>
We have now written a method or two, but we haven't declared them, so go back to viewcontroller.h. Where your instance variables go, add <code>BOOL moveViewUp;</code> and <code>CGFloat scrollAmount;</code>. Right before <code>@end</code>, add <code>- (void)scrollTheView:(BOOL)movedUp;</code>.<br>
<br><br><br>
<b>7. Lowering the view again</b><br>
Pretty self-explanatory. The textfield relinquishes its status as the First Responder, and scrolls back down if necessary.<br>
<pre><code>-(BOOL)textFieldShouldReturn:(UITextField *) theTextField {<br>
   [theTextField resignFirstResponder];<br>
   if (moveViewUp)<br>
      [self scrollTheView:NO];<br>
   return YES;<br>
}<br>
</code></pre>
<br><br>
<b>8. Adding the TextFieldDelegate protocol</b><br>
<code>textFieldShouldReturn</code> is a method declared by the <code>UITextFieldDelegate</code> protocol. On a basic level, adopting a protocol declares methods for you. To do this, go to viewcontroller.h and type <code>&lt;UITextFieldDelegate&gt;</code> after <code>UIViewController</code> and before <code>}</code>.<br>
<br><br><br>
<b>9. More Connecting in Interface Builder</b><br>
Open up viewcontroller.xib, and right click file's owner. Right click the textfield, but on the right side in between the x and the circle. Under outlets, drag the circle next to delegate to File's Owner.  Scrolling is now done!<br>
<br><br><br>
<b>10. Create a way to store the text</b><br>
Before we can do anything with the typed text, we must store it in an instance variable. In the header file, type in <code>NSString *enteredText;</code> and it's accessors: <code>@property (nonatomic, retain) NSString *enteredText;</code>. Then add <code>@synthesize enteredText;</code> to the implementation file.<br>
<br><br><br>
<b>11. Doing stuff with the text...</b><br>
Add the following method to viewcontroller.m:<br>
<pre><code>- (void)updateEnteredText {<br>
   self.enteredText = textField.text;<br>
   label.text = self.enteredText;<br>
}<br>
</code></pre>
Also add <code>[self updateEnteredText];</code> to textFieldShouldReturn, right before <code>return YES;</code>. Then, add <code>- (void)updateEnteredText;</code> to the header file, and finally, add <code>[enteredText release];</code> to the dealloc method.<br>
<br><br><br>
<b>12. Sit back and admire your work!</b>
<br><br><br>
<h3>Notes</h3>
1) If you want to make multiple textfields, repeat steps 1, 2, 9, 10, and 11 for each extra one. Keep in mind for step 11 to assign a new label if you need it.<br>