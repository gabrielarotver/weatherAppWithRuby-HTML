require 'nokogiri'
require 'httparty'

url = 'https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%202450080&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys'

response = HTTParty.get url

date = response["query"]["results"]["channel"]["item"]["condition"]["date"]
temp = response["query"]["results"]["channel"]["item"]["condition"]["temp"]
description=response["query"]["results"]["channel"]["item"]["condition"]["text"]

text = File.read('index.html')

new_contents = text.gsub(/Date:(.)*/, "Date: #{date}</h3>")

new_contents = new_contents.gsub(/Temperature:(.)*/, "Temperature: #{temp}&deg;F</h3>")

new_contents = new_contents.gsub(/Conditions(.)*/, "Conditions: #{description}</h3>")

File.open('index.html',"w") {|file| file.puts new_contents }
