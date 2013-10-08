# Writrr.li

## What is Writrr.li?

Writrr is a social platform all about writing, sharing and exploring stories in any kind of way. Everyone is blessed with his very own imagination, so I can say: Writrr is a project for everyone. It's especially provided to authors and people who'd like to become an author.

There will be no overkill of features, it's just about text. I'll provide you a clear and easy system with smooth design to let you write and share your own stories. You're also able to discover all the stories of other authors and let them know what's cool about their stories.

## What are the main features?

- Write
- Share
- Discover

As I told you: No bullshit of useless features. It's all about the stories.

## The idea

Some time ago, me and my friend [Kevin](http://kevingimbel.com) went to a bar in [Mayence](http://goo.gl/maps/BpAET) and had some beer. After a couple of topics we talked about creating a new project together. We always had good ideas but never something we're **totally** impressed of.

Anyway, Kevin talked about one of his ideas. [Readrr](http://www.readrr.li). This project is all about reading books. If you want to get more information, just visit the link.

So I came up with an equivalent idea for "writing books". I kinda copied the name with two "r" but Kevin was fine with that

## The roadmap of Writrr.li

First of all, Writrr will be programmed using Ruby on Rails. I used to started programming it in OOPHP but this was just to test the system and see how it rolls. In this section I'm going to write and show you how I developed Writrr from scratch to deployment.

### 00. Developing setup

- Ubuntu
- Sublime Text 2
- Github
- Chrome
- Awesome music

### 01. The default setup

To create my new Rails application I'm running the following command via console:

    $ rails new writrr.li -d mysql -T

This will provide me a full Rails construction within the folder <tt>writrr.li</tt>. I prefer to use mysql as the databse and skip the rails test units. To open and edit the file I go inside that new folder with:

    $ cd writrr.li
    $ subl . &

Now I can see all the files in my Sublime Text Editor. Let's see if the application is already running by typing this:

    $ rails s

or

    $ rails server

Wait for about 2 seconds, open your browser and go to <tt>http://localhost:3000</tt>, this is the default URL for a local running rails system. A pages shows up that tells me "Welcome aboard". Nice, now I only need to write millions of code lines I'm ready to deploy. FML.

If nothing shows up and you're getting some errors you can just go to Step 02.

### 02. Database details

