class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  # add routes

  get '/bakeries'  do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])

    baked_goods = bakery.baked_goods

    options = {
      include: :baked_goods,
      except:  [:created_at, :updated_at]
    }

    bakery.to_json(options)
  end

  get '/baked_goods/by_price' do 
    baked_goods = BakedGood.order(price: :desc)
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do 
    most_expensive = BakedGood.order(price: :desc).first
    most_expensive.to_json
  end

end
