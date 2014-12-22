# Authentication

All API requests need to be authenticated with a JWT key passed in as a parameter called 'token'. There are a couple of steps to get this key.

Redirect the user to /auth with a paramter of redirect_uri specifying where to redirect to.

For development purposes if you are a memeber of the macropodhq GitHub org you can use any url you want.

Once the app will redirect to the given url with a paramter of token set to the JWT, which you can then use for API requests