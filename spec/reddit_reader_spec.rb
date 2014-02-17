require 'spec_helper'

describe 'RedditReader' do
  let(:url) { 'http://reddit.com/.json' }
  let(:reddit_reader) { RedditReader.new(url) }
  let(:titles) {
    [
      "TIL Mike Tyson offered",
      "advisory",
      "Was looking in my moms college yearbook",
      "Baby Olinguito",
      "Captain Underpants movie announced",
      "Cubone of War",
      "I'm well past college but with all",
      "Hi Reddit! Barnaby Phillips here,",
      "Vila Franca's Islet,",
      "Baltimore local helps",
      "Well, that's a bad day",
      "Golden Retriever guards",
      "Shipwrecked man makes land",
      "Footage released of Guardian editors",
      "What is the most complicated",
      "Why is it that after a long night",
      "The upside to being let go by Nokia",
      "Hemp",
      "South Park's 201",
      "If enamel can't be regenerated",
      "Picard and Gandalf",
      "A long as America is enamored with NZ",
      "Never read sci-fi until this morning,",
      "Today is the final day of the Combined",
      "I attached my camera"
    ]
  }

  describe '::new' do
    it 'takes a url on initialization' do
      expect(reddit_reader.url).to eq(url)
    end
  end

  describe '#read!' do
    it 'creates Post instances for each post' do
      use_vcr('reddit_posts') do
        reddit_reader.read!
        titles.each_with_index do |title, i|
          expect(reddit_reader.posts[i].title).to match(/#{titles[i]}/)
        end
      end
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
      titles.each do |title|
        expect(file).to match(/#{title}/)
      end
    end
  end
end