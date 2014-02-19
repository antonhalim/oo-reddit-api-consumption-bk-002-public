require 'spec_helper'

describe 'RedditReader' do
  let(:url) { 'http://www.reddit.com/r/technology/.json' }
  let(:reddit_reader) { RedditReader.new(url) }
  let(:titles) do
    File.read('spec/fixtures/titles.txt').each_line.map do |line|
      line.strip
    end
  end
  let(:titles_for_matching) do
    File.read('spec/fixtures/short_titles.txt').each_line.map do |line|
      line.strip
    end
  end
  let(:over_18_title) { "This syringe filled with high-tech mini sponges can seal a bullet wound in seconds" }

  describe '::new' do
    it 'takes a url on initialization' do
      expect(reddit_reader.url).to eq(url)
    end
  end

  describe '#read!' do
    before do
      use_vcr('reddit_posts') do
        reddit_reader.read!
        @post_titles = reddit_reader.posts.map {|p| p.title}
      end
    end
    it 'creates Post instances for each post' do
      titles.each do |title|
        expect(@post_titles).to include(title)
      end
    end

    it 'doesn\'t store posts that contain NSFW material' do
      expect(@post_titles).to_not include(over_18_title)
    end
  end

  describe '#generate_html' do
    after do
      FileUtils.rm(File.expand_path('generated_html.html'))
    end

    it 'generates an html page containing all posts' do
      use_vcr('reddit_posts') do
        reddit_reader.read!
      end
      
      reddit_reader.generate_html('generated_html.html')
      file = File.read(File.expand_path('generated_html.html'))
      titles_for_matching.each do |title|
        expect(file).to match(/#{title}/)
      end
    end
  end
end