# Jurnal App Store
Jurnal has created a new feature called Jurnal AppStore which 3rd party developers can create applications inside Jurnal to integrate their platform with Jurnal.

<h2>Jurnal App Store</h2>
You can access our developer platform in https://developer.jurnal.id. In this website you can register your application.
<h3>Glossary</h3>

<h4>Basic Information</h4>
  - App Name: Application Name.
  - App Icon: Application Icon.
  - App URL: Callback URL of your application which Jurnal will render it for the first time.
  - App Short Description: Short Description of your application (150 characters minimum and 366 characters maximum).
  - Scope: Your application credential to access user's data.
  
<h4>App Store Listing</h4>
  - Request for Beta: Request your application to Jurnal admin to be visible by Jurnal users with 'Beta' status once your application is approved.   
  - Request for Publication: Request your application to Jurnal admin to be visible by Jurnal users once your application is approved.
  - Banner: Banner images of your application. You can insert up to 5 banners to your application.
  - Youtube URL: Your application youtube link(in case you have it).
  - Full Description: A full description which describes your application.
  - Manual URL: Your manual link of your application guide book
  - Email: Your application/company email.
  - Phone: Your application/company phone.
  - Website URL: Your application/company website URL.
  
# Access Token

Once Jurnal render your application, your application will be given the access token to to access user's data. We generate the access token for your application and we will give it to your application via Javascript's <code>postMessage()</code> method. You have to implement the receiver but don't worry, we already create a javascript library for you to create the receiver in <a href= 'https://github.com/squadronjurnal/Jurnal-Integration-Library'>here</a>.

<h3> How to use the library </h3>
  - Use the script in your application callback URL page. The script contains <code>JurnalIntegration</code> object that will receive the access_token given from Jurnal and store it with the <a href='https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage'>sessionStorage()</a> method
  - Once you get the access token, you can use the access token by add the script in the defined page and call <code>JurnalIntegration.get_access_token()</code>.
  
The access token will be give to your application every time user open your application.

# Rendering 3rd Party Application

If you want to try your registered application to be rendered in application, here's what you can do:
  - Go to the developer center and go to your application. Then click 'App Store Listing'. 
  - Your application is currenctly unpublished, but you can access it in Jurnal by clicking link in top of the page
  - You will be redirected to Jurnal. Click 'Install'
  - Once you installed your app, your application will be registered as add on in your Jurnal's account.
  - Click 'Open'
  - Your application will be rendered inside Jurnal's application.

# Sample App
This is a sample application to <strong>guide</strong> you to create applications in Jurnal. 

<h2>Getting Started</h2>

<h3>Install sample app to your local</h3>
  - Clone this repo
  - Install Ruby Version 2.2.4 and Rails 4.2.5.1
  - Run <code>bundle install</code>
  - Run <code>rake db:create</code>, <code>rake db:schema</code>, <code>rake db:migrate</code>
  - Run the server using <code>rails s -b 0.0.0.0 -p 2000</code>.
  - Run <code>localhost:2000</code>
  
<h3>Create Your App in Jurnal AppStore</h3>
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
    
# Webhook

To activate webhook, you have to register it from your application using<br>
<code>POST https://api.jurnal.id/core/dev/oauth/webhooks?client_id={your_application_client_ID}&access_token={the_access_token_given}</code><br>
We give you the webhook user id. This webhook user ID will be unique per user who install your application.

To get current webhook, you can use <br>
<code>GET https://api.jurnal.id/core/dev/oauth/webhooks?client_id={your_application_client_ID}&access_token={the_access_token_given}</code><br>

To inactivate current webhook, you can use <br>
<code>DELETE https://api.jurnal.id/core/dev/oauth/webhooks?client_id={your_application_client_ID}&access_token={the_access_token_given}</code><br>

*note =if you test it in sandbox.jurnal.id, use https://sandbox-api.jurnal.id instead of  https://api.jurnal.id

Every time user who has the webhook user ID create, update, or delete data in Jurnal, our webhook service will send the data that's user manipulated to your callback URL with POST method with user's <strong>webhook user ID as the header</strong>. The format body that is:
<pre>
  {
    "notification":{
        "company_id: {user's company ID in Jurnal} -> integer
        "action": {user's action} -> string
        "object":{data subject that is user's manipulated} -> string
        "object_details":{the data detail} -> hash
    }
  }
</pre>

By this format you can use it by your own purpose.

To use webhook in the development, we provide <a href='https://ngrok.com/'>ngrok<a> so webhook service can access to your localhost. run <code>./ngrok http -region ap 2000</code> for Mac or <code>ngrok http -region ap 2000</code> for Windows. Then update your app callback URL with URL given by the ngrok



  


    

    



  
 



