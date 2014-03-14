
Instructions:
Write some C++ code that takes cd_catalog.xml (attached) as input and converts it to an HTML file.
 
Requirements:
- The code should be written in C++.
- It can be a single executable that takes the file name as input.
- The output HTML should be formatted as a "table" element.
- Sorting is not important for this challenge.
- Try to document your decisions, either in the code comments or in a separate readme file.
- There are no other constraints.  Google to your heart’s content.  
  Use any libraries you want, and any platform you want (Mac OS, Windows, Linux, etc.).
 
Try to implement this as you would if you were doing actual work for Carbonite, 
although things like efficiency are not terribly important for this challenge.  
However, if you do make any tradeoffs, please document/explain them.  Also, if 
you re-use any existing code or libraries, please include references.  Preferably, 
try to write some of your own code that demonstrates objected oriented design 
and good engineering practices.

=========================================================
=========================================================
Comments:

I wrote a command line utility with Objective-C.

I did look at many of the XML parser libs out there, but I found most haven't been updated 
in quite a while (especially in regards to ARC) So I decided to roll my own via Apple's 
provided NSXMLParser protocol.

I decided to use a SAX parser since I haven't used one before. It would be more useful 
for reading in large files since it gives you the chance to save off collected values
and keep the memory footprint small. In that case you'd probably off-load content to a
static storage along the way.

I created a simple class for CD in which to store attributes. I didn't use a class for 
Catalog since it would be only a wrapper for an array with no added functionality. If Catalog 
had a title or some other functionality a class would have been needed. If I knew that
there would be plans to add functionality I would go ahead and create the class for future
convencience.

The CatalogParser class is an example of the type class Kaz and I were discussing Wednesday.
It shows a class being used to group functionality together and implement a protocal.

The CatalogPageCreator class does not implement a protocol, but is still an example of a
class being used to collect related functionality together. If the HTML being created
was more complicated and/or offered more customization via file input, then this could
be its own class just for generating the HTML.

Error feedback was provided to the user at locations where the app could not continue
execution if the condition existed: no input file name, an unreadble or empty file, 
parser generated an error, there was a problem creating the output file.



