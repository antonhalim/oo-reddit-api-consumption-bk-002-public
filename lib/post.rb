class Post
attr_accessor :title, :url, :upvotes, :downvotes, :content, :image_url

  def initialize(hash)
    @title = hash[:title]
    @url = hash[:url]
    @upvotes = hash[:upvotes]
    @downvotes = hash[:downvotes]
    @content = hash[:content]
    @image_url = hash[:image_url]
  end

  def to_html
    # binding.pry
          "<li>
            <a href=\"#{url}\">
                <h1>#{title}</h1>
                <img src=\"#{image_url}\" />
                <h4>Upvotes:</p>
                <p>#{upvotes}</h4>
                <p>#{content}</p>
                <p>Downvotes:</p>
                <h4>#{downvotes}</h4>
            </a>
          </li>"
  end
end
