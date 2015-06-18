require 'rails_helper'

describe "API" , :type => :api do

describe "GET" do

  before do
    @restaurant = Restaurant.create(name:'Urthcafe')
    @restaurant.reviews.create(thoughts: 'Fine', rating: 5)
  end

  it "requests restaurants" do
    get "/api/restaurants"
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).first['name']).to eq('Urthcafe')
  end

  it "requests reviews" do
    get "/api/restaurants/#{@restaurant.id}/reviews"
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).first['thoughts']).to eq('Fine')
    expect(JSON.parse(last_response.body).first['rating']).to eq(5)
  end
end

describe "POST" do

  it "creates a restaurant" do
    params = {name: "Trade", description: "its Ok"}
    post "/api/restaurants", params.to_json, "CONTENT_TYPE" => "application/json"
    expect(last_response.status).to eq(201)
    expect(JSON.parse(last_response.body)['name']).to eq('Trade')
  end

end

  describe "PUT" do
    before do
      @restaurant = Restaurant.create(name:'Urthcafe', description: 'Fine')
      @restaurant.reviews.create(thoughts: 'Fine', rating: 5)
    end

    it "updates a restaurant" do
      params = {name: "Hooters", description: 'Fine'}
      put "/api/restaurants/#{@restaurant.id}", params.to_json, "CONTENT_TYPE" => "application/json"
      expect(last_response.status).to eq(200)
      puts last_response.body
      expect(last_response.body).to eq("true")
    end

  end

end
