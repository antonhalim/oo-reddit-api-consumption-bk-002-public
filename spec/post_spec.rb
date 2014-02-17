require 'spec_helper'

describe 'Post' do
  let(:post_attributes) {
    {
      title: "This is a Title",
      url: "http://www.google.com/",
      upvotes: 1000,
      downvotes: 256,
      content: "Wow, much awesome.",
      image_url: "http://imagebucket.com/image.jpg"
    }
  }

  let(:post) { Post.new(post_attributes) }

  describe '#title' do
    it 'has a title' do
      expect(post.title).to eq(post_attributes[:title])
    end
  end

  describe '#url' do
    it 'has a url' do
      expect(post.url).to eq(post_attributes[:url])
    end
  end

  describe '#upvotes' do
    it 'has an upvote count' do
      expect(post.upvotes).to eq(post_attributes[:upvotes])
    end
  end

  describe '#downvotes' do
    it 'has a downvote count' do
      expect(post.downvotes).to eq(post_attributes[:downvotes])
    end
  end

  describe '#content' do
    it 'has content' do
      expect(post.content).to eq(post_attributes[:content])
    end
  end

  describe '#image_url' do
    it 'has an image url' do
      expect(post.image_url).to eq(post_attributes[:image_url])
    end
  end

  describe '#to_html' do
    let!(:html) { post.to_html }

    it 'includes the <li> opening and closing tags' do
      expect(html).to match(/(?=.*<li>)(?=.*<\/li>)/m)
    end

    it 'contains the url' do
      expect(html).to match(/href="#{post_attributes[:url]}"/)
    end

    it 'contains the title' do
      expect(html).to match(/#{post_attributes[:title]}/)
    end

    it 'contains the number of upvotes' do
      expect(html).to match(/#{post_attributes[:upvotes]}/)
    end

    it 'contains the number of downvotes' do
      expect(html).to match(/#{post_attributes[:downvotes]}/)
    end

    it 'contains any post content' do
      expect(html).to match(/#{post_attributes[:content]}/)
    end

    it 'contains the image url' do
      expect(html).to match(/<img src="#{post_attributes[:image_url]}" \/>/)
    end
  end
end