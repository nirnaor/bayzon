# Bayzon

Bayzon is a simple web app that given a URL of a product in [eBay](ebay.com) returns a list of products and sellers in [Amazon](amazon.com). You can look at the product by [clicking here](mysterious-mountain-23299.herokuapp.com).

## Technical Stack
  - Ruby on Rails
  - [Mechanize](http://docs.seattlerb.org/mechanize/) for scraping the content
  - [Slim](http://slim-lang.com/) for fast and fun templating.

## General workflow
1. In order to extract the product name from the page in eBay, I used the first 3 words of the title.
2. Given the product name, I scraped the results of Amazon's search for the given name. 
3. Since the procecss of extracting is slow (involves many poges) I used [ActionCable](https://github.com/rails/rails/tree/master/actioncable) to reload new products, so the user doesn't have to wait until the entire process is done.


## Open issues
1. The queries I used using mechanize shold be much faster, I wasn't sure about the fastest way to use the the selectors.
2. Even tough I'm emulating the user agent to be a browser, I'm still getting 503 from time to time. I'm not sure about the best way 
3. Once the user closes the tab, the process of page extracting is still running.
4. When clicking 'back' and 'forward' on chrome, some results are returned to different product query (related to the pub/sub mechanism probably).
5. The flash messages appear sometimes even when they are not needed.

