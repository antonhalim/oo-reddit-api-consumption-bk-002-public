require 'json'
require 'rest_client'
require 'pry'

class RedditReader


  attr_accessor :url, :posts

  def initialize(url)
    @url = url
    @posts = []
  end

  def read!
    reddit_hash = JSON.parse(RestClient.get(url))
    result_hash = {}
    reddit_hash["data"]["children"].each do |post_hash|
      result_hash[:title] = post_hash["data"]["title"]
      result_hash[:url] = post_hash["data"]["url"]
      result_hash[:upvotes] = post_hash["data"]["ups"]
      result_hash[:content] = post_hash["data"]["selftext"]
      result_hash[:downvotes] = post_hash["data"]["downs"]
      result_hash[:image_url] = post_hash["data"]["thumbnail"]
      if post_hash["data"]["over_18"] == false
        @posts << Post.new(result_hash)
      end
    end
  end

  def generate_html(file_path)
    File.open(file_path,"w") do |file|
      posts.each do |post|
      file.write(post.to_html)
      end
    end
  end
end
