--- 
title: Web Scraping | CRONje.ME
label: Web Scraping
order: 5
authors:
  - name: Charl Cronje
    email: charl@CRONje.ME
    link: https://blog.cronje.me
    avatar: https://assets.cronje.me/avatars/darker.jpg
---
This vignette introduces you to the basics of web scraping with rvest. You’ll first learn the basics of HTML and how to use CSS selectors to refer to specific elements, then you’ll learn how to use rvest functions to get data out of HTML and into R.

<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

```R
library(rvest)
```

## HTML basics

HTML stands for `HyperText Markup Language` and looks like this:

```html
<html>
<head>
  <title>Page title</title>
</head>
<body>
  <h1 id='first'>A heading</h1>
  <p>Some text &amp; <b>some bold text.</b></p>
  <img src='myimg.png' width='100' height='100'>
</body>
```

HTML has a hierarchical structure formed by **elements** which consist of a start tag (e.g. `<tag>`), optional attributes (`id='first'`), an end tag1 (like `</tag>`), and **contents** (everything in between the start and end tag).

Since < and > are used for start and end tags, you can’t write them directly. Instead you have to use the HTML `escapes` &gt; (greater than) and &lt; (less than). And since those escapes use &, if you want a literal ampersand you have to escape it as &amp;. There are a wide range of possible HTML escapes but you don’t need to worry about them too much because rvest automatically handles them for you.

## Elements

All up, there are over 100 HTML elements. Some of the most important are:

- Every HTML page must be must be in an `<html>` element, and it must have two children: `<head>`, which contains document metadata like the page title, and `<body>`, which contains the content you see in the browser.
- Block tags like `<h1>` (heading 1), `<p>` (paragraph), and `<ol>` (ordered list) form the overall structure of the page.
- Inline tags like `<b>` (bold), `<i>` (italics), and `<a>` (links) formats text inside block tags.

If you encounter a tag that you’ve never seen before, you can find out what it does with a little googling. I recommend the MDN Web Docs which are produced by Mozilla, the company that makes the Firefox web browser.

## Contents

Most elements can have content in between their start and end tags. This content can either be text or more elements. For example, the following HTML contains paragraph of text, with one word in bold.

Hi! My name is Hadley.

The children of a node refers only to elements, so the `<p>` element above has one child, the `<b>` element. The `<b>` element has no children, but it does have contents (the text “name”).

Some elements, like `<img>` can’t have children. These elements depend solely on attributes for their behavior.

## Attributes

Tags can have named attributes which look like name1='value1' name2='value2'. Two of the most important attributes are id and class, which are used in conjunction with CSS (Cascading Style Sheets) to control the visual appearance of the page. These are often useful when scraping data off a page.

Reading HTML with rvest

You’ll usually start the scraping process with `read_html()`. This returns a `xml_document2` object which you’ll then manipulate using rvest functions:

```R
html <- read_html("http://rvest.tidyverse.org/")
class(html)
#> [1] "xml_document" "xml_node"
```

For examples and experimentation, `rvest` also includes a function that lets you create an `xml_document` from literal HTML:

```R
html <- minimal_html("
  <p>This is a paragraph<p>
  <ul>
    <li>This is a bulleted list</li>
  </ul>
")
html
#> {html_document}
#> <html>
#> [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 ...
#> [2] <body>\n<p>This is a paragraph</p>\n<p>\n  </p>\n<ul>\n<li>This is a bull ...
```

Regardless of how you get the `HTML`, you’ll need some way to identify the elements that contain the data you care `about`. rvest provides two options: `CSS` selectors and `XPath` expressions. Here I’ll focus on `CSS` selectors because they’re simpler but still sufficiently powerful for most scraping tasks.

## CSS selectors

`CSS` is short for cascading style sheets, and is a tool for defining the visual styling of HTML documents. `CSS` includes a miniature language for selecting elements on a page called `CSS` selectors. `CSS` selectors define patterns for locating HTML elements, and are useful for scraping because they provide a concise way of describing which elements you want to extract.

`CSS` selectors can be quite complex, but fortunately you only need the simplest for rvest, because you can also write R code for more complicated situations. The four most important selectors are:

```R
p: selects all <p> elements.

.title: selects all elements with class “title”.

p.special: selects all <p> elements with class “special”.

#title: selects the element with the id attribute that equals “title”. Id attributes must be unique within a document, so this will only ever select a single element.
```

If you want to learn more `CSS` selectors I recommend starting with the fun `CSS` dinner tutorial and then referring to the `MDN` web docs.

Lets try out the most important selectors with a simple example:

```R
html <- minimal_html("
  <h1>This is a heading</h1>
  <p id='first'>This is a paragraph</p>
  <p class='important'>This is an important paragraph</p>
")
```

In rvest you can extract a single element with `html_element()` or all matching elements with `html_elements()`. Both functions take a document3 and a css selector:

```R
html %>% html_element("h1")
#> {html_node}
#> <h1>
html %>% html_elements("p")
#> {xml_nodeset (2)}
#> [1] <p id="first">This is a paragraph</p>
#> [2] <p class="important">This is an important paragraph</p>
html %>% html_elements(".important")
#> {xml_nodeset (1)}
#> [1] <p class="important">This is an important paragraph</p>
html %>% html_elements("#first")
#> {xml_nodeset (1)}
#> [1] <p id="first">This is a paragraph</p>
```

- Selectors can also be combined in various ways using combinators. For example,The most important combinator is ” “, the descendant combination, because p a selects all `<a>` elements that are a child of a `<p>` element.

If you don’t know exactly what selector you need, I highly recommend using SelectorGadget, which lets you automatically generate the selector you need by supplying positive and negative examples in the browser.

## Extracting data

Now that you’ve got the elements you care about, you’ll need to get data out of them. You’ll usually get the data from either the text contents or an attribute. But, sometimes (if you’re lucky!), the data you need will be in an `HTML` table.

## Text

Use `html_text2()` to extract the plain text contents of an HTML element:

```R
html <- minimal_html("
  <ol>
    <li>apple &amp; pear</li>
    <li>banana</li>
    <li>pineapple</li>
  </ol>
")
html %>% 
  html_elements("li") %>% 
  html_text2()
#> [1] "apple & pear" "banana"       "pineapple"
```

Note that the escaped ampersand is automatically converted to &; you’ll only ever see `HTML` escapes in the source `HTML`, not in the data returned by rvest.

You might wonder why I used `html_text2()`, since it seems to give the same result as `html_text()`:

```R
html %>% 
  html_elements("li") %>% 
  html_text()
#> [1] "apple & pear" "banana"       "pineapple"
```

The main difference is how the two functions handle white space. In `HTML`, white space is largely ignored, and it’s the structure of the elements that defines how text is laid out. `html_text2()` does its best to follow the same rules, giving you something similar to what you’d see in the browser. Take this example which contains a bunch of white space that HTML ignores.

```R
html <- minimal_html("<body>
  <p>
  This is
  a
  paragraph.</p><p>This is another paragraph.
  
  It has two sentences.</p>
")
html_text2() gives you what you expect: two paragraphs of text separated by a blank line.

html %>% 
  html_element("body") %>% 
  html_text2() %>% 
  cat()
#> This is a paragraph.
#> 
#> This is another paragraph. It has two sentences.
Whereas html_text() returns the garbled raw underlying text:

html %>% 
  html_element("body") %>% 
  html_text() %>% 
  cat()
#> 
#>   
#>   This is
#>   a
#>   paragraph.This is another paragraph.
#>   
#>   It has two sentences.
```

## Attributes

Attributes are used to record the destination of links (the href attribute of `<a>` elements) and the source of images (the src attribute of the `<img>` element):

```R
html <- minimal_html("
  <p><a href='https://en.wikipedia.org/wiki/Cat'>cats</a></p>
  <img src='https://cataas.com/cat' width='100' height='200'>
")
The value of an attribute can be retrieved with html_attr():

html %>% 
  html_elements("a") %>% 
  html_attr("href")
#> [1] "https://en.wikipedia.org/wiki/Cat"

html %>% 
  html_elements("img") %>% 
  html_attr("src")
#> [1] "https://cataas.com/cat"
```

Note that `html_attr()` always returns a string, so you may need to post-process with `as.integer()/readr::parse_integer()` or similar.

```R
html %>% 
  html_elements("img") %>% 
  html_attr("width")
#> [1] "100"

html %>% 
  html_elements("img") %>% 
  html_attr("width") %>% 
  as.integer()
#> [1] 100
```
## Tables

HTML tables are composed four main elements: `<table>`, `<tr>` (table row), `<th>` (table heading), and `<td>` (table data). Here’s a simple HTML table with two columns and three rows:

```R
html <- minimal_html("
  <table>
    <tr>
      <th>x</th>
      <th>y</th>
    </tr>
    <tr>
      <td>1.5</td>
      <td>2.7</td>
    </tr>
    <tr>
      <td>4.9</td>
      <td>1.3</td>
    </tr>
    <tr>
      <td>7.2</td>
      <td>8.1</td>
    </tr>
  </table>
  ")
```

Because tables are a common way to store data, rvest includes the handy html_table() which converts a table into a data frame:

```R
html %>% 
  html_node("table") %>% 
  html_table()
#> # A tibble: 3 × 2
#>       x     y
#>   <dbl> <dbl>
#> 1   1.5   2.7
#> 2   4.9   1.3
#> 3   7.2   8.1
```

## Element vs elements

When using rvest, your eventual goal is usually to build up a data frame, and you want each row to correspond some repeated unit on the HTML page. In this case, you should generally start by using `html_elements()` to select the elements that contain each observation then use `html_element()` to extract the variables from each observation. This guarantees that you’ll get the same number of values for each variable because `html_element()` always returns the same number of outputs as inputs.

To illustrate this problem take a look at this simple example I constructed using a few entries from dplyr::starwars:

```R
html <- minimal_html("
  <ul>
    <li><b>C-3PO</b> is a <i>droid</i> that weighs <span class='weight'>167 kg</span></li>
    <li><b>R2-D2</b> is a <i>droid</i> that weighs <span class='weight'>96 kg</span></li>
    <li><b>Yoda</b> weighs <span class='weight'>66 kg</span></li>
    <li><b>R4-P17</b> is a <i>droid</i></li>
  </ul>
  ")
```

If you try to extract name, species, and weight directly, you end up with one vector of length four and two vectors of length three, and no way to align them:

```R
html %>% html_elements("b") %>% html_text2()
#> [1] "C-3PO"  "R2-D2"  "Yoda"   "R4-P17"
html %>% html_elements("i") %>% html_text2()
#> [1] "droid" "droid" "droid"
html %>% html_elements(".weight") %>% html_text2()
#> [1] "167 kg" "96 kg"  "66 kg"
```

Instead, use `html_elements()` to find a element that corresponds to each character, then use `html_element()` to extract each variable for all observations:

```R
characters <- html %>% html_elements("li")

characters %>% html_element("b") %>% html_text2()
#> [1] "C-3PO"  "R2-D2"  "Yoda"   "R4-P17"
characters %>% html_element("i") %>% html_text2()
#> [1] "droid" "droid" NA      "droid"
characters %>% html_element(".weight") %>% html_text2()
#> [1] "167 kg" "96 kg"  "66 kg"  NA
html_element() automatically fills in NA when no elements match, keeping all of the variables aligned and making it easy to create a data frame:

data.frame(
  name = characters %>% html_element("b") %>% html_text2(),
  species = characters %>% html_element("i") %>% html_text2(),
  weight = characters %>% html_element(".weight") %>% html_text2()
)
#>     name species weight
#> 1  C-3PO   droid 167 kg
#> 2  R2-D2   droid  96 kg
#> 3   Yoda    <NA>  66 kg
#> 4 R4-P17   droid   <NA>
```