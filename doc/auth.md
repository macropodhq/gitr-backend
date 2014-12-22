# Authentication

All API requests need to be authenticated with a JWT key passed in as a parameter called 'token'. There are a couple of steps to get this key.

## GitHub OAuth

Perform a standard [GitHub OAuth request](https://developer.github.com/v3/oauth/), and collect the oauth code. This token does not need any additional scopes.

## Swap OAuth for JWT

Post to /v1/authorize.json with the OAuth code in the 'code' field. You will be provided with the user's profile and a JWT.

Example response:
```
{
  "token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNWFlZWM4YWYtMzY1MS00MGFjLTgyNDctOTNmYzJhMzlmZGU5IiwiZXhwIjoxNDE5MjMxNTM5fQ.oUQOJJbKi4UttNxUsWTWGn-Sx0XBsVbmRVWvHALtxys",
  "id":"5aeec8af-3651-40ac-8247-93fc2a39fde9",
  "login":"aussiegeek",
  "avatar_url":"https://avatars.githubusercontent.com/u/475?v=3",
  "location":"Melbourne, Australia",
  "name":"Alan Harper"
}
```

Store the value returned for token

## Authenticate requests

For all future requests, pass this token in the token field to documented APIs. Beware this JWT token has a fairly short life span (hours). When it expires, API requests will start returning HTTP 401, with a json body of
```
{"error": "JWT expired"}
```
