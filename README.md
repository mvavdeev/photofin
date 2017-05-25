# Photogram Final Solutions

## Solutions Setup

 1. Clone
 1. `bundle`
 1. `rake db:migrate`
 1. `rake db:seed`
 1. `rails server`
 1. Sign in as `alice@`, `bob@`, `carol@`, `dave@`, or `ellen@example.com` (password: `12341234`).

===

1. Add [starter_generators](https://gist.github.com/rbetina/80d3cf2cf82666ed1c0f) and [Devise](https://gist.github.com/rbetina/9ef4a9ffa4604df74bb5) to the Gemfile.
1. `bundle install`
1. Suppose we design the following domain model:

                                           +---------------------+
                                           |                     |
                                           |Comment              |
                                          /|=======              |\
                           +---------------|- body:text          |---------------+
                           |              \|- photo_id:integer   |/              |
                           |               |- user_id:integer    |               |
                           |               |                     |               |
                           |               +---------------------+               |
                           |                                                     |
                           |                                                     |
                           -                                                     -
                           |                                                     |
                +---------------------+                               +---------------------+
                |                     |                               |User                 |
                |Photo                |                               |====                 |
                |=====                |\                              |- username:string    |
                |- caption:string     |-----------------------------|-|- Devise columns     |
                |- image:string       |/                              |(email, password,    |
                |- user_id:integer    |                               |etc)                 |
                |                     |                               |                     |
                +---------------------+                               +---------------------+
                           |                                                     |
                           -                                                     -
                           |                                                     |
                           |                                                     |
                           |               +---------------------+               |
                           |               |                     |               |
                           |               |Like                 |               |
                           |              /|====                 |\              |
                           +---------------|- photo_id:integer   |---------------+
                                          \|- user_id:integer    |/
                                           |                     |
                                           |                     |
                                           +---------------------+

  - Associations
     - Users have many photos, a photo belongs to a user
     - Photos have many comments, a comment belongs to a photo
     - Users have many comments, a comment belongs to a user
     - Users have many likes, a like belongs to a user
     - Photos have many likes, a like belongs to a photo
     - Users have many liked_photos through likes (source: photo)
     - Photos have many fans through likes (source: user)
  - Validations
     - User
         - username: presence, uniqueness
     - Photo
         - user_id: presence
     - Like
         - user_id: presence, uniqueness in combination with photo
         - photo_id: presence
     - Comment
         - user_id: presence
         - photo_id: presence
         - body: presence

1. Generate the User account resource [with Devise](https://gist.github.com/rbetina/9ef4a9ffa4604df74bb5#generate-a-new-model-with-devise):

    ```shell
    rails generate devise:install
    rails generate devise user username:string
    ```

    Devise will automatically add email, password, and all the other columns that it needs to secure accounts. You just specify any columns you want besides those.

1. Generate the rest of your CRUD resources [with starter_generators](https://gist.github.com/rbetina/80d3cf2cf82666ed1c0f#resources):

    ```shell
    rails generate starter:resource photo caption:text image:string user_id:integer
    rails generate starter:resource like user_id:integer photo_id:integer
    rails generate starter:resource comment photo_id:integer body:text user_id:integer
    ```

1. Now that you have generated your model files, add all of your associations and validations immediately.
1. Set the root URL to the photos index page:

    ```ruby
    # In config/routes.rb
    root "photos#index"
    ```
1. You can finally `rails server` and navigate to [http://localhost:3000](http://localhost:3000) to see your work so far. If you haven't `rake db:migrate`d yet, it will ask you to now.
1. Generate [a better application layout](https://gist.github.com/rbetina/80d3cf2cf82666ed1c0f#application-layout), including Bootstrap:

    ```shell
    rails generate starter:style paper
    ```

1. I've included some random starter data for you to use while developing:

    ```shell
    rake db:seed
    ```

    Now click around the app and see what we've got.

1. Let's require that someone be signed in before they can do anything else. In `application_controller.rb`, add the line

    ```ruby
    before_action :authenticate_user!
    ```
1. Sign in with one of the seeded users; you can use `alice@example.com`, `bob@example.com`, or `carol@example.com`. All of the passwords are `12341234`.

1. Fix the dummy edit profile and sign-out links in the navbar.
 - If there is currently a signed-in user,
     - The link to edit profile should display the signed-in user's username instead.
     - The link to sign out should work as is, but remove the word "dummy".
 - If not, display links to sign-in (`/users/sign_in`) and sign-up (`/users/sign_up`) instead.

1. On the new photo form, the user should not have to provide their ID number. Fix it using Devise's `current_user` helper method.

1. Create an RCAV: When I visit [http://localhost:3000/users](http://localhost:3000/users), I should see an index of all users. Add a link to the navbar.

1. Create an RCAV: When I visit [http://localhost:3000/users/1](http://localhost:3000/users/1), I should see the details of user #1 along with all of his or her photos.

1. Create an RCAV: When I visit [http://localhost:3000/my_likes](http://localhost:3000/my_likes), I should see only the photos that I have liked.  Add a link to the navbar.

1. On the photo show page, I should only see the "Edit" and "Back" buttons if it is my own photo.

1. Make the photos index page look like [the target](https://photogram-auth-target.herokuapp.com/photos):
  - Useful Bootstrap things: [panel with heading](http://getbootstrap.com/components/#panels-heading), [media list](http://getbootstrap.com/components/#media-list), [img-responsive](http://getbootstrap.com/css/#images-responsive)
  - Userful Rails methods: [time_ago_in_words](http://apidock.com/rails/ActionView/Helpers/DateHelper/time_ago_in_words), [.pluck](http://guides.rubyonrails.org/active_record_querying.html#pluck), [.to_sentence](http://apidock.com/rails/Array/to_sentence)

   View Source on the target if you need to.

1. Make the form to add a comment work.
1. Make the heart to like/unlike work.
1. Customize Devise form

1. Optional: Carrierwave
1. Optional: Social Network

tests:
 - index shows photos, comments, likes, oxford comma, time ago in words
