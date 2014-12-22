See https://github.com/trentm/restdown for how this is formatted.

## GET /suggestions

Gets a few suggested people to connect with.

It should not return people that you've already decided on, either negatively
or positively.

#### example request

> $ curl https://api.gitr.io/suggestions

#### example response

```json
{
	"suggestions": [
		{
			"id": "0123456789abcdef",
			"whatever": "here"
		}
	]
}
```

## POST /suggestions/:id

Accept or reject a suggestion. Post a boolean value, get a response. It's a fair
trade.

#### example request

> $ curl -X POST -d true https://api.gitr.io/suggestions/0123456789abcdef

#### example response

The match field is either an ID, or null. If it's null, the person that the
suggestion represents has either said no, not seen you, or not responded. If
it's not null, it refers to a `match` record. See the next section for what that
is.

```json
{
	"match": null
}
```

```json
{
	"match": "0123456789abcdef"
}
```

## GET /matches

Gets a list of your matches. These are people that have liked you, and that
you've liked.

#### example request

> $ curl https://api.gitr.io/matches

#### example response

```json
{
	"matches": [
		{
			"id": "123123123",
			"name": "ojame"
		},
		{
			"id": "456456456",
			"name": "aussiegeek"
		}
	]
}
```

## GET /matches/:id

Gets the activity between you and a match. This is just conversation messages at
the moment.

#### example request

> $ curl https://api.gitr.io/matches/123123123

#### example response

```json
{
	"id": "123123123",
	"name": "ojame",
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

> $ curl -X POST -d '{"text": "this is a message"}' \
>   https://api.gitr.io/matches/123123123/messages

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

> $ curl -X DELETE https://api.gitr.io/matches/123123123
