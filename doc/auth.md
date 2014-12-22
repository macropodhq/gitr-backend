# Authentication

All API requests need to be authenticated with a JWT key passed in as a parameter called 'token'. There are a couple of steps to get this key.

## GitHub OAuth

Perform a standard [GitHub OAuth request](https://developer.github.com/v3/oauth/), and fetch an OAuth access token. This token does not need any additional scopes.

## Swap OAuth for JWT

Post to /v1/authorize.json with the OAuth access token passed in the token field.

Example response:
```
{"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNWFlZWM4YWYtMzY1MS00MGFjLTgyNDctOTNmYzJhMzlmZGU5IiwiZXhwIjoxNDE5MjE4NzM2fQ.VYeZ4ISzj2MWJ2QZy3kJ-oeDf3ptI0ynL_GOoHMQfDQ"}
```

Store the value returned for token

## Authenticate requests

For all future requests, pass this token in the token field to documented APIs. Beware this JWT token has a fairly short life span (hours). When it expires, API requests will start returning HTTP 401, with a json body of
```
{"error": "JWT expired"}
```
