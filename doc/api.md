See https://github.com/trentm/restdown for how this is formatted.

## GET /people

Gets a few people to maybe connect with.

It should not return people that you've already decided on, either negatively
or positively.

#### example request

```
$ curl https://api.gitr.io/people
```

#### example response

```json
{
  "people": [
    {
      "id": "456456456",
      "name": "ojame",
      "repos": [
        {"name": "whatever", "yep": "there's more"},
        {"name": "oh look wow", "haha": "what"}
      ]
    }
  ]
}
```

## GET /matches

Gets a list of your matches. These are people that have liked you, and that
you've liked.

#### example request

```
$ curl https://api.gitr.io/matches
```

#### example response

```json
{
  "matches": [
    {
      "id": "123123123",
      "created_at": "2014-12-22T00:00:00.000Z",
      "person": {
        "id": "456456456",
        "name": "ojame",
        "repos": [
          {"name": "whatever", "yep": "there's more"},
          {"name": "oh look wow", "haha": "what"}
        ]
      }
    },
    {
      "id": "456456456",
      "created_at": "2014-12-22T00:00:00.000Z",
      "person": {
        "id": "789789789",
        "name": "aussiegeek",
        "repos": [
          {"name": "whatever", "yep": "there's more"},
          {"name": "oh look wow", "haha": "what"}
        ]
      }
    }
  ]
}
```

## POST /matches

Try to create a match. If the `person` referenced doesn't exist, it will return
a `406 unacceptable` response. If they do exist, and have also chosen to match
with you, it will return a `201 created` response with a redirect to the match
record, and in any other case will return a `202 accepted` reponse with no
content. If the `match` field is `true`, it'll be registered as your intent to
match with that person. If it's `false`, it'll be registered as disinterest, and
won't ever result in a `match` record being created.

#### example request

```
$ curl -X POST -d '{"person": {"id": "123123"}, "match": true}' \
  https://api.gitr.io/matches
```

## GET /matches/:id

Gets the activity between you and a match. This is just conversation messages at
the moment.

#### example request

```
$ curl https://api.gitr.io/matches/123123123
```

#### example response

```json
{
  "id": "123123123",
  "created_at": "2014-12-22T00:00:00.000Z",
  "person": {
    "id": "456456456",
    "name": "ojame",
    "repos": [
      {"name": "whatever", "yep": "there's more"},
      {"name": "oh look wow", "haha": "what"}
    ]
  },
  "messages": [
    {
      "id": "789789",
      "time": "2014-12-22T00:00:00.000Z",
      "from": "ojame",
      "text": "Hello! I like your JavaScript projects!"
    },
    {
      "id": "789790",
      "time": "2014-12-22T00:05:00.000Z",
      "from": "deoxxa",
      "text": "Well thanks! What do you think about React?"
    }
  ]
}
```

## POST /matches/:id/messages

Post a chat message to a match.

#### example request

```
$ curl -X POST -d '{"text": "this is a message"}' \
  https://api.gitr.io/matches/123123123/messages
```

#### example response

```json
{
  "id": "789789",
  "time": "2014-12-22T00:00:00.000Z",
  "from": "deoxxa",
  "text": "this is a message"
}
```

## DELETE /matches/:id

Delete a match, thus removing their ability to talk to you via gitr.

#### example request

```
$ curl -X DELETE https://api.gitr.io/matches/123123123
```
