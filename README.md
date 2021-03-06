---
  tags: oop, api, json
  languages: ruby
  resources: 2
---

# Object Oriented Reddit Reader

## Description

In this lab, we'll be consuming the Reddit JSON api in order to pull data from
the site and reformat and organize it according to our needs.

### JSON

Speaking of JSON...what is it, exactly? JSON, or JavaScript Object Notation, is a
standard format used to send data as human-readable text between a server and a web
application. It looks very similar to a Ruby hash, and consists of key-value (or
attribute-value) pairs. A JSON object might look something like this:

```
{
  "firstName": "Bob",
  "lastName": "Smith",
  "address": {
    "streetAddress": "100 First Street",
    "city": "Somewhere",
    "state": "NY"
  }
}
```

Using the `json` Ruby module, we get a handfull of very useful methods that will take
a JSON object and convert it into a Ruby hash. So, assuming we have a JSON object
stored in the variable `data`, we can convert it into a hash like this:

```ruby
new_hash = JSON.parse(data)
```

### Browsing the Reddit API

Install the following Chrome or Firefox extension:

* https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc

* https://addons.mozilla.org/en-us/firefox/addon/jsonview/

Then, visit `http://reddit.com/.json` in your browser and have a look around!

## Instructions

### Setup

From within the project directory, run the following command in your console. (Note
that the '$' just indicates your prompt. Don't type it in.)

```bash
$ bundle
```

What this does is make use of a lovely utility called [Bundler](http://bundler.io/), 
that manages and installs any Ruby gems we need for our project and ensures that 
they are properly included in our environment. If you take a look in `Gemfile`, 
you can see what gems are being installed.

Some of the installed gems are only used for the purposes of the RSpec test suite, but you may want to do a little research on [rest_client](https://github.com/rest-client/rest-client). It is the gem that we will use to request JSON from Reddit. Also, it's worth taking a look at the documentation on the [JSON Module](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/json/rdoc/JSON.html).

### SFW Reddit

A hash of stories from the Reddit front page can now be retrieved using the following statement:

`reddit_hash = JSON.parse(RestClient.get('http://reddit.com/.json'))`

Retrieve the Reddit hash in a `pry` or `irb` session and play with it interactively.
(If you play around with it in irb, make sure to `require 'json'` and `require 'rest_client'`! Otherwise, you will get errors about JSON and RestClient.) All your code will
be placed in two Ruby classes, but playing with the hash in irb is a useful tool when
getting to know a complex data structure.

You will have two classes, `RedditReader` and `Post`. The `RedditReader` class should be responsible for parsing the JSON response from Reddit, and the `Post` class will contain the data for each post. Follow along with the specs, and you will be guided to write the necessary methods. (Note: Our `RedditReader` class will act as a factory that creates instances of the `Post` class from the JSON it gets from Reddit.)

We want to generate an HTML page that excludes all posts that are NSFW (not safe for work).
This is indicated by the `over_18` field.

Take the filtered Reddit stories and generate the following string with every story having it's own `<li>`:

    <html>
      <head>
      </head>
      <body>
        <ul>
          <li>
            <a href="REDDIT URL">
                <h1>POST TITLE</h1>
                <img src="THUMBNAIL URL" />
                <h4>Upvotes:</p>
                <p>NUMBER OF UPVOTES</h4>
                <p>Downvotes:</p>
                <h4>NUMBER OF DOWNVOTES</h4>
            </a>
          </li>
          .
          .
          .
          <li>
            <a href="REDDIT URL">
                <h1>POST TITLE</h1>
                <img src="THUMBNAIL URL" />
                <h4>Upvotes:</h4>
                <p>NUMBER OF UPVOTES</p>
                <h4>Downvotes:</h4>
                <p>NUMBER OF DOWNVOTES</p>
            </a>
          </li>
        </ul>
      </body>
    </html>
    

Make sure to replace the capitalized strings with their respective values from the Reddit API.

For instance, given a story that contains the following values:

    { 
        ups: 10, 
        downs: 5, 
        permalink: "/r/funny/comments/1nkf6g/bane_also_ran_into_that_woman/",
        title: "Bane also ran into that woman.",
        thumbnail: "http://d.thumbs.redditmedia.com/6RWoT7UpEd_momgc.jpg"
    }
    
Your `<li>` would look like this:

        <li>
            <a href="http://reddit.com/r/funny/comments/1nkf6g/bane_also_ran_into_that_woman/">
                <h1>Bane also ran into that woman.</h1>
                <img src="http://d.thumbs.redditmedia.com/6RWoT7UpEd_momgc.jpg" />
                <h4>Upvotes:</h4>
                <p>10</p>
                <h4>Downvotes:</h4>
                <p>5</p>
            </a>
          </li>

Also, browsers ignore indentation whitespace when parsing HTML, so it's not necessary
for your string to duplicate the indentation whitespace shown above.
    
Finally, have your script write the string to a file called "reddit.html". Then, 
try opening it in your browser!
## Resources
* [Ruby Docs](http://www.ruby-doc.org/) - [JavaScript Object Notation (JSON)](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/json/rdoc/JSON.html)
* [Codecademy](http://www.codecademy.com/) - [Intro to JSON and API](http://www.codecademy.com/courses/twin-acronyms/0/1)
