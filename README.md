# Jurnal App Store
Jurnal has created a new feature called Jurnal AppStore which 3rd party developers can create applications inside Jurnal to integrate their platform with Jurnal.

<h2>Jurnal App Store</h2>
You can access our developer platform in https://developer.jurnal.id. In this website you can register your application.
<h4>Glossary</h4>
  <h5>Basic Information</h5>
    - App Name: Application Name.
    - App Icon: Application Icon.
    - App URL: Callback URL of your application which Jurnal will render it for the first time.
    - App Short Description: Short Description of your application (150 characters minimum and 366 characters maximum).
    - Scope: Your application credential to access user's data.
  <h5>App Store Listing</h5>
    - Request for Beta: Request your application to Jurnal admin to be visible by Jurnal users with 'Beta' status once your application is approved.   
    - Request for Publication: Request your application to Jurnal admin to be visible by Jurnal users once your application is approved.
    - Banner: Banner images of your application. You can insert up to 5 banners to your application.
    - Youtube URL: Your application youtube link(in case you have it).
    - Full Description: A full description which describes your application.
    - Manual URL: Your manual link of your application guide book
    - Email: Your application/company email.
    - Phone: Your application/company phone.
    - Website URL: Your application/company website URL.

# Sample App
This is a sample application to <strong>guide</strong> you to create applications in Jurnal. 

<h2>Getting Started</h2>

<h4>Install sample app to your local</h4>
  - Clone this repo
  - Install Ruby Version 2.2.4 and Rails 4.2.5.1
  - Run <code>bundle install</code>
  - Run <code>rake db:create</code>, <code>rake db:schema</code>, <code>rake db:migrate</code>
  - Run the server using <code>rails s -b 0.0.0.0 -p 2000</code>.
  - Run <code>localhost:2000</code>
  
<h4>Create Your App in Jurnal AppStore</h4>
  - Go to <link>https://developer.jurnal.id</link>
  - Login or register your account
  - Once you're verified, sign in with your account
  - Click 'Add'
  - Complete your application information, then click 'Save'
  - To complete application additional information, click 'App Store Listing' to insert banner image, youtube link, etc. Then, click      'Save
  - Add this variable to your localhost environment variable<br>
    <pre>
      APP_CLIENT_ID= your application client ID
      JURNAL_BASEPATH= Jurnal API endpoint (https://api.jurnal.id for my.jurnal.id or https://sandbox-api.jurnal.id for sandbox.jurnal.id)
    </pre>


