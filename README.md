# Message Board

* Ruby: 2.6.2
* Rails: 5.2.3
* Database: Postgresql

Run `rails test` to run the test suite.

Run `rails s`to start the server

Use curl or postman to send api-requests to the server

get `/posts` returns all messages from the message board

To post messages, first create a user account at `/signup` or use the rails console
eg `curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST -d '{"user": { "name": "Hello world", "email": "test@example.com", "password": "password" }}' http://localhost:3000/register`

then get a jwt token from `curl -H "Content-Type: application/json" -H "Accept: application/json" -X POST -d '{ "email": "test@example.com", "password": "password" }' http://localhost:3000/authenticate`

Use the returned token in all subsequent api calls in the header `Authorization: auth_token`
for example: 
## POST
`curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjIxMDQxODB9.iMkJWuyE9NusEl204xfwsmjWqGxTs9cmtX203Btpgpo" -H "Content-Type: application/json" -H "Accept: application/json" -X POST -d '{"post": { "body": "Hello world" }}' http://localhost:3000/posts`
## PATCH
`curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjIxMDQxODB9.iMkJWuyE9NusEl204xfwsmjWqGxTs9cmtX203Btpgpo" -H "Content-Type: application/json" -H "Accept: application/json" -X PATCH -d '{"post": { "body": "Hello all the world" }}' http://localhost:3000/post/21`
## DELETE
`curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NjIxMDQxODB9.iMkJWuyE9NusEl204xfwsmjWqGxTs9cmtX203Btpgpo" -H "Content-Type: application/json" -H "Accept: application/json" -X DELETE http://localhost:3000/post/21`


