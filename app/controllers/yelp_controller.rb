require "http";

class YelpController < ApplicationController

   API_KEY = "WTknuy37fu844_0llVQVc7-snemAtXe7Uthm7T80_ypKXzvn9mw8BeB2fJP36lbrCBtf63wXmajcUEAxXLMH-Qx1lTb7-HChVCQhFiABlcNU66VeRYV_zR66UA4PW3Yx"

   # Constants, do not change these
   API_HOST = "https://api.yelp.com"
   SEARCH_PATH = "/v3/businesses/search"
   BUSINESS_PATH = "/v3/businesses/"
   SEARCH_LIMIT = 10

   def get_next_course

     filter = input_params

     userId = params[:filter][:userId]
     groupId = params[:filter][:groupId]

     # Step 1, find all friends associated with group_id
     selectedGroup = Group.find(groupId)
     friends = selectedGroup.friends
     winFriendIndex = rand(friends.length) - 1
     winningFriend = friends[winFriendIndex]

     #  actual yelp API call
     response = search(selectedGroup,winningFriend)

     # puts "Found #{response["total"]} businesses. Listing #{SEARCH_LIMIT}:"
     # response["businesses"].each {|biz| puts biz["name"]}

     winNumber = rand(response["businesses"].length) - 1

     winning_restaurant = response["businesses"][winNumber]

     winningRestaurant = winning_restaurant["name"]
     winningUrl = winning_restaurant["url"]

     user = User.find(userId  )

     outingParams = { "winner": winningFriend.name,
                      "winning_restaurant": winningRestaurant,
                      "winning_group": selectedGroup.name,
                      "url": winningUrl}

     # outingParams.permit(:winner,:winning_restaurant,:winning_group,:url)

     outing = Outing.new(outingParams)

     user.outings << outing

     render json: response["businesses"][winNumber]

   end

   def search(selectedGroup,winningFriend)

     url = "#{API_HOST}#{SEARCH_PATH}"
     yelpParams = {
       term: winningFriend.preference,
       location: selectedGroup.location,
       price: selectedGroup.price_range,
       open_now: true,
       limit: SEARCH_LIMIT
     }

     response = HTTP.auth("Bearer #{API_KEY}").get(url, params: yelpParams)

     response.parse
   end

   private
   def input_params
     params.require(:filter).permit(:userId,:groupId)
   end

end
