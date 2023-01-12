# GET /album Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

Method: GET
Path: /album

## 2. Request

## List all albums

Request:
GET /albums

Response (200 OK):
A list of albums

## List a specific album

Request:
GET /albums/{:id}

Response (200 OK):
A specific album


## Create a new album

Request:
POST /albums

With body parameters:
  title="OK computer"
  release_year="1997"
  artist_id="5"

Response (200 OK):
No content, just create the new resourse (new album)



## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```
Doolittle
Surfer Rosa
OK computer
```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /albums

# Response (200 OK):

A list of albums
Doolittle
Surfer Rosa
Waterloo	
Super Trouper	
Bossanova	
Lover	
Folklore	
I Put a Spell on You
Baltimore	
Here Comes the Sun
Fodder on My Wings
Mezzanine	
Definitely Maybe	

```

```
# Request:

GET /posts?id=276278

# Expected response:

Response for 404 Not Found
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/posts?id=1')

      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
