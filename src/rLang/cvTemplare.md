---
title: CV in R Markdown | CRONje.ME
label: CV in R Markdown 
order: 155
authors:
  - name: Charl Cronje
    email: charl@CRONje.ME
    avatar: https://assets.cronje.me/avatars/darker.jpg
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

||| RStudio
Why aren’t you using [R Markdown](http://rmarkdown.rstudio.com/) already? I’ve offered an argument why you should consider doing everything in R Markdown with posts about [my academic manuscript template](http://svmiller.com/blog/2016/02/svm-r-markdown-manuscript/) and [my integration of R Markdown with Beamer](http://svmiller.com/blog/2015/02/moving-from-beamer-to-r-markdown/) 

(see updated [Beamer-R Markdown template here](https://github.com/svmiller/svm-r-markdown-templates)).
||| RMarkdown
![Curriculum vitae](img/5.png)
|||

I recently moved my CV from pure LaTeX to R Markdown. Here’s the template I used. You can find the template and minimal working example on my Github.

## Getting Started with YAML

This is what the YAML will resemble for an R Markdown CV that uses my template. I provide a sample YAML metadata taken from my example document and explain it below. The code should be intuitive if you’ve seen my previous examples or have prior familiarity with R Markdown or YAML.

```yml
---
**output:** 
  pdf_document:
    latex_engine: pdflatex
    **template:** ~/Dropbox/miscelanea/svm-r-markdown-templates/svm-latex-cv.tex
geometry: margin=1in

****title:**** "CV"
author: William Sealy Gosset

job****title:**** "Chief Brewer, Arthur Guinness & Son"
address: "Guinness Brewery · Park Royal · London NW10 7RR, UK"
**fontawesome:** yes
**email:** guinness@consumer-care.net
# **github:** svmiller
phone: "+353 1 408 4800"
web: guinness.com
updated: no

keywords: R Markdown, academic CV, template

fontfamily: mathpazo
fontfamilyoptions: sc, osf
fontsize: 11pt
linkcolor: blue
urlcolor: blue
---
```

We start with **output:**, which tells us we want a PDF document on the next line (with two indented spaces). Thereafter, we specify some PDF document options. latex_engine will rely on pdflatex, which is my rendering engine of choice for LaTeX (because I love the mathpazo family of fonts). **template:** specifies the relative path of my template (titled svm-latex-cv.tex). Make sure it points to wherever you saved this template.

**title:** and author: should be intuitive. Make **title:** some value like “CV” or “vita”. I’ll defer on your particular choice of words. author: should be your name. My template chooses William Sealy Gosset, who introductory quantitative students may know as “Student” of Student’s t-distribution fame. Gosset may be one of the most underappreciated statisticians of all time. He was also a researcher and brewer for Arthur Guinness & Son, now known as Guinness. Fun fact: Gosset wrote under the pseudonym of “Student” because Guinness frowned on his statistical side projects and forbade its scientists from publishing research for fear of it being useful to rival brewers.

My endorsement of his importance to the field of applied statistics should not be confused as an endorsement of that awful beer. You could do better than Guinness.

The next two lines will constitute the first two lines after your name on your CV. Add your particular job title in the job**title:** field (e.g. Assistant Professor, Department of Political Science). Add your address in the address: field thereafter. Note: R Markdown is flexible with most forms of Unicode, which is why I have dots separating what are otherwise “lines” on a mailing address.

The next option is a wrinkle I added to this document for pure cosmetic effect. TeX updates starting in 2015 (I think?) make the incredibly useful fontawesome package work with the pdflatex rendering engine. A LaTeX user previously needed XeLaTeX in order to use fontawesome. Add **fontawesome:** yes to your YAML if you want to use these fonts, but also make sure your TeX Live package is current. See here for a guide on how to do that. Do note this defaults to “no” in the absence of this entry, in which case there is no issue of fontawesome’s incompatability with other versions of TeX Live.

The next five lines will constitute items at the bottom row of the header of the CV. At the least, put your e-mail address in the **email:** field. You don’t need to do this for the template to work but what is the point of having a CV without at least an e-mail address attached to it?

You can also give a phone number or Github account name in the phone: or **github:** fields. You could conceivably use both items, but you might run out of space. I omit a phone number in my personal CV but add a link to my Github account. You can always choose to not use either field.

Add your domain name in the web: field (without the http://) for a link to your website.

updated: is an optional entry. I like to broadcast when my CV was last updated in the header of my CV. Perhaps you don’t want this. I have updated: yes in my personal CV if you want to see what that looks like.

## The Template in Action
My hope is the reader already knows what markdown syntax looks like. Markdown is awesome.

You can also find how to use R Markdown and knitr to run R code within your R Markdown document, allowing for dynamic report generation. You could well do this with your publications using something like [RefManageR](https://cran.r-project.org/web/packages/RefManageR/index.html). I don’t think it’s worth it for a CV, though it’s an easy addition.

This is what the template looks like in action.

### [http://svmiller.com/cv/](http://svmiller.com/cv/)

And

### [CV Marisa Mayer](examples/cv_md_Marissa_Mayer.pdf)
  - [https://www.overleaf.com/read/mmzschwckjvt](https://www.overleaf.com/read/mmzschwckjvt)

- [Docco Style](http://ashkenas.com/docco/)
- [Cheat Sheat Style](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
