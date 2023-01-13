require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET to /" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello!")
    end
  end

  context "GET /names-array" do
    it "returns an html list of names" do
      response = get('/names-array')

      expect(response.body).to include('<p>Anna</p>')
      expect(response.body).to include('<p>Josh</p>')
      expect(response.body).to include('<p>Marco</p>')
    end
  end

  context "GET /name" do
    it "return an html message with a given name" do
      response = get('/name', name: 'Marta')

      expect(response.body).to include('<h1> Hello Marta!</h1>')
      expect(response.body).to include('<img src="hello.jpg" />')
    end

    it "return an html message with another name" do
      response = get('/name', name: 'Leo')

      expect(response.body).to include('<h1> Hello Leo!</h1>')
      expect(response.body).to include('<img src="hello.jpg" />')
    end
  end

  context "GET /password" do
    it "returns an hello page if the password correct" do
      response = get('/password', password: 'abcd')

      expect(response.body).to include('Hello!')
    end

    it "returns a forbidden page if the password is uncorrect" do
      response = get('/password', password: 'abcdfsd')

      expect(response.body).to include('Access forbidden!')
    end
  end

  context "POST to /submit" do
    it "returns 200 OK with the right content" do
      # Send a POST request to /submit
      # with some body parameters
      # and returns a response object we can test.
      response = post("/submit", name: "Dana", message: "Hello world")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Thanks Dana, you sent this message: Hello world")
    end
  end

  context "GET to /names" do
    it "returns 200 OK with the right content" do 
      response = get("/names", names: "Julia, Mary, Karim")

      expect(response.status).to eq 200
      expect(response.body).to eq ("Julia, Mary, Karim")
    end
  end

  context "POST /sort-names" do 
    it 'returns 200 OK and the list of sorted names' do
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end

  context "GET /hello" do
    it "returns an hello message" do
      response = get('/hello')

      expect(response.body).to include('<h1>Hello!</h1>')
    end
  end
end