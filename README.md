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

Wait for about 2 seconds, open your browser and go to <tt>http://localhost:3000</tt>, this is the default URL for a local running rails system. Probably an error shows up, telling you there's no database or the wrong details were provided.

### 02. Database details

The database details are located inside the <tt>config</tt>-folder. If we open it, we can see three section of details:

- <tt>development</tt>
- <tt>test</tt>
- <tt>production</tt>

I'm developing on my localhost, so I just need to change the <tt>development<tt>-section for now:

    development:
      adapter: mysql2
      encoding: utf8
      database: writrr_li_development
      pool: 5
      username: root
      password:
      socket: /var/run/mysqld/mysqld.sock

Added <tt>username</tt> and <tt>password</tt> and ready to go.

Now go back to your console and run the follwing line to create your database:

    $ rake db:create

Should be done in 1 sec. Try to run the server again. A page should show which says "Welcome aboard". Nice, now I only need to write millions of code lines I'm ready to deploy. FML.

### 03. Hello Rails

To change the default index page and say "Hello" for the first time I open <tt>config/routes.rb</tt>. Somewhere at the top you can find the following line:

    # root 'welcome#index'

First of all: uncommend. It says the root/index document should be loaded by the <tt>welcome</tt>-controller and the <tt>index</tt>-method. In my case I change it to:

    root 'pages#index'

I'll get an error again if I try to run the server. Of course, because I just told rails it shall open the a page by a non-existing controller and method. So whats next? I keep that step in mind and go on with the next step.

### 04. Prepare scaffolding

The most important thing to create a Rails project is to make sure "What do I need?". First of all think of the database structure, relations and indexes. I came up with the following for now (can be customized at anytime):

    |- users
      |- username
      |- email
      |- password
      |- name
      |- image
      |- link
      |- location
      |- bio
    |- stories
      |- title
      |- teaser
      |- genre
    |- chapters
      |- title
      |- content
    |- ratings
    |- follows

Rails automatically adds <tt>id</tt>, <tt>created_at</tt> and <tt>updated_at</tt> fields. So you don't need to take care of.

Next part for me would be the relations:

    users **1 = n** stories
    stories **1 = n** chapters
    chapters **1 = n** ratings
    follows **1 = n** users
    users **n = 1** follows
