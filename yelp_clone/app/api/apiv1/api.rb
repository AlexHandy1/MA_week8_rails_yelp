module API
  class APIV1 < Grape::API
    version 'v1', using: :header, vendor: 'yelp'
    format :json
    prefix :api

    resource :restaurants do
      desc "List all Restaurants"

      get do
        Restaurant.all
      end

      desc "create a new Restaurant"

      params do
        requires :name, type: String
        requires :description, type: String
      end

      post do
        Restaurant.create(name: params[:name], description: params[:description])
      end

      desc "Update restaurant details"

      put ':restaurant_id' do
        Restaurant.find(params[:restaurant_id]).update({
          name: params[:name]
          })
      end

      desc "Show restaurant reviews"

      get '/:restaurant_id/reviews' do
        @restaurant = Restaurant.find(params[:restaurant_id])
        @restaurant.reviews
      end


    end
  end
end
