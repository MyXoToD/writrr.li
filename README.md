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

This will provide me a full Rails construction within the folder <tt>writrr.li</tt>. I prefer to use mysql as databse and skip the rails test units. To open and edit the files I go inside that new folder with:

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

I'm developing on my localhost, so I just need to change the <tt>development</tt>-section for now:

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

I'll get an error again if I try to run the server. Of course, because I just told rails it shall open a page by a non-existing controller and method. So what next? I keep that step in mind and go on with the next step. This step will be finished at step 6.

### 04. Prepare scaffolding

The most important thing to create a Rails project is to make sure "What do I need?". First of all think of the database structure, relations and indexes. I came up with the following for now (can be customized at anytime):

    DATABASE:
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
      |- value
    |- follows

    FILESYSTEM:
    |- pages

Rails automatically adds <tt>id</tt>, <tt>created_at</tt> and <tt>updated_at</tt> fields. So you don't need to take care of.

Next part for me would be the relations:

    users     1 = n  stories
    stories   1 = n  chapters
    chapters  1 = n  ratings
    follows   1 = n  users
    users     n = 1  follows
    ratings   n = 1  chapters
    ratings   1 = 1  users

Now I have a more or less clear database and filesystem structure of what I need. To make sure you understand what I mean with the filesystem part: This will be a controller to handle static pages like the index-, about-, ... pages.

### 05. Scaffolding

Scaffolds are an easy way to add controllers, models, helpers and so on to fulfill all your needs (= step 04).

First of all I'll create a scaffold for the pages (remember step 03). This is actually no real scaffold but it fits into this section:

    $ rails g controller pages

or

    $ rails generate controller pages

**Hint:** At anytime you create something with <tt>rails g</tt> make sure you write plural words in lowercase and singular words in first letter uppercase. (pages or Page).

New files will be added to our filesystem:

    create  app/controllers/pages_controller.rb
    invoke  erb
    create    app/views/pages
    invoke  helper
    create    app/helpers/pages_helper.rb
    invoke  assets
    invoke    coffee
    create      app/assets/javascripts/pages.js.coffee
    invoke    scss
    create      app/assets/stylesheets/pages.css.scss

Let's go on with the real scaffolding. First users:

    $ rails g scaffold User username email password name image link location bio:text

This will add some files to our filesystem again. We added the scaffold <tt>User</tt> with all it's attributes. The default attribute type is <tt>string</tt>. I only changed it to <tt>text</tt> for bio.

Next stories:

    $ rails g scaffold Story title teaser:text genre user:references

A story has a title, teaser and genre. So I added these as attributes. I also added <tt>users:references</tt>, this provides me a relationship between users and stories. If I now open <tt>app/models/story.rb</tt> I can see <tt>belongs_to :users</tt>. As it should be.

Next chapters:

    $ rails g scaffold Chapter title content:text story:references

The same thing like for stories now happend for the chapters. Only that the <tt>app/models/chapter.rb</tt> now says <tt>belongs_to :stories</tt>.

Alright, next thing would be the rating:

    $ rails g scaffold Rating value:integer user:references chapter:references

Rating only has a value and belongs to users **and** chapters.

And once more for the follows (note: this is a little but more complex).

First we're going to add a new model for the relationships:

    $ rails generate model Relationship follower_id:integer followed_id:integer

After that we navigate to <tt>db/migrate/[TIMESTAMP]_create_relationships.rb</tt> and add some indexes:

    class CreateRelationships < ActiveRecord::Migration
      def change
        create_table :relationships do |t|
          t.integer :follower_id
          t.integer :followed_id

          t.timestamps
        end
        add_index :relationships, :follower_id
        add_index :relationships, :followed_id
        add_index :relationships, [:follower_id, :followed_id], unique: true
      end
    end

Because we have every scaffold done before we're ready to migrate the database and prepare the test database as usual:

    $ bundle exec rake db:migrate

Now open the <tt>app/models/user.rb</tt> and edit it like this:

    class User < ActiveRecord::Base
      has_many :relationships, foreign_key: "follower_id", dependent: :destroy
      has_many :followed_users, through: :relationships, source: :followed
      has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
      has_many :followers, through: :reverse_relationships, source: :follower
    end

After that we edit the <tt>app/models/relationship.rb</tt> like this:

    class Relationship < ActiveRecord::Base
      belongs_to :follower, class_name: "User"
      belongs_to :followed, class_name: "User"
      validates :follower_id, presence: true
      validates :followed_id, presence: true
    end

Let's add some more methods to the <tt>app/models/user.rb</tt>-model (like follow and unfollow):

    class User < ActiveRecord::Base
      has_many :relationships, foreign_key: "follower_id", dependent: :destroy
      has_many :followed_users, through: :relationships, source: :followed

      def following?(other_user)
        relationships.find_by(followed_id: other_user.id)
      end

      def follow!(other_user)
        relationships.create!(followed_id: other_user.id)
      end

      def unfollow!(other_user)
        relationships.find_by(followed_id: other_user.id).destroy!
      end
    end

Now we go back to the <tt>config/routes.rb</tt> to add the follow attributes to user. Change this:

    resources :users

to this:

    resources :users do
      member do
        get :following, :followers
      end
    end

This should do the trick. Let's go on with the next step now. We'll come back to that following topic as soon as I'm ready to implement it into the frontend.

### 06. Hello Rails 2

Let's finish step 3 now. We now added all controllers and so on, so we're ready to let Rails speak to us. For this we open <tt>app/controllers/pages_controller.rb</tt> and change it like this:

    class PagesController < ApplicationController
      def index

      end
    end

To add the index page, we go to <tt>app/views/pages/</tt> and add a new file called <tt>index.html.erb</tt>. Fill this file with <tt>Hello Rails!</tt>. Remember? We added <tt>pages#index</tt> in <tt>config/routes.rb</tt> to be our root page. Now start the server again with <tt>rails s</tt> and locate to <tt>http://localhost:3000</tt>.

Yay it says "Hello Rails!" :)

### 07. Many many many

When I created the scaffolds, I told Rails which references should be created. Like N stories belongs to 1 user and so on. Now we need to do the same just in the opposite way. We start with the <tt>app/models/user.rb</tt>. Add this right on top:

    has_many :stories
    has_many :ratings

Now we go to <tt>app/models/story.rb</tt> and add this:

    has_many :chapters

And again at <tt>app/models/chapter.rb</tt>:

    has_many :ratings

### 08. User management

As default we can locate to <tt>http://localhost:3000/users</tt> in the browser to see a listing of all registered users, sign up, edit and delete. Pretty nice because we only did a scaffold for the users and we have all the functionalities. Anyway, there's a big problem right now. Well, there are a couple of problems:

- No login
- No sign up authentification
- Every user can edit every stories and anything else

So you can see, there are a couple of things we need to implement, forbid and permit.

I was told about a pretty nice Ruby on Rails gem, which is called <tt>devise</tt>. You can find it [on Github](https://github.com/plataformatec/devise).

First thing we gonna do is installing the gem like this:

Open <tt>Gemfile</tt> and add:

    gem 'devise'

Now run the generator via console:

    $ rails generate devise:install

Now you see some instructions in your console. Please follow them before continue.