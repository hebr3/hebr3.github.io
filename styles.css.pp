#lang pollen

◊;Based on the work of Matthew Butterick and Joel Dueck
◊(require css-tools)
/* Hi! */

◊(make-media-query 24 10.5 1000 40 .25)
◊;(font-face-declaration "FiraMono-Regular" "/css/FiraMono-Regular.woff" #:base64 #t)

◊;(font-face-declaration "SourceSansPro-Regular" "/css/sourcesanspro-400.woff" #:base64 #t)

◊;(font-face-declaration "SourceSansPro-Bold" "/css/sourcesanspro-700.woff" #:base64 #t)

◊;(font-face-declaration "SourceSansPro-It" "/css/sourcesanspro-400i.woff" #:font-style "italic" #:base64 #t)

◊;(font-face-declaration "SourceSansPro-BoldIt" "/css/sourcesanspro-700i.woff" #:font-style "italic" #:base64 #t)

@font-face {
    font-family: 'FiraMono';
    font-style: normal;
    font-weight: normal;
    font-stretch: normal;
    src: local('FiraMono-Regular'), url(/css/FiraMono-Regular.woff) format('woff')
}

@font-face {
    font-family: 'Source Sans Pro';
    font-style: normal;
    font-weight: 400;
    src: local('SourceSansPro-Regular'), url(/css/sourcesanspro-400.woff) format('woff')
}

@font-face {
    font-family: 'Source Sans Pro';
    font-style: normal;
    font-weight: 700;
    src: local('SourceSansPro-Bold'), url(/css/sourcesanspro-700.woff) format('woff')
}

@font-face {
    font-family: 'Source Sans Pro';
    font-style: italic;
    font-weight: 400;
    src: local('SourceSansPro-It'), url(/css/sourcesanspro-400i.woff) format('woff')
}

@font-face {
    font-family: 'Source Sans Pro';
    font-style: italic;
    font-weight: 700;
    src: local('SourceSansPro-BoldIt'), url(/css/sourcesanspro-700i.woff) format('woff')
}

◊;;;;;;;;;;;;;;;;;;;;;;;;;;;

◊;* {
◊;  padding: 0;
◊;  margin: 0;
◊;  border: 0;
◊;  box-sizing: border-box;
◊;  font-weight: inherit;
◊;  font-style: inherit;
◊;  font-size: inherit;
◊;  text-decoration: inherit;
◊;  color: inherit;
◊;  width: 100%;
◊;}

◊(define hover-color "#fbf3f3")
◊(define link-hover-transition ◊make-css-transition["background" "0.2s"])

a:hover {
background: ◊|hover-color|;
◊|link-hover-transition|
border-radius: 8px;
}

a {
◊|link-hover-transition|
}

◊;;;;;;;;;;;;;;;;;;;;;;;;
.gridded {
    background-image: linear-gradient(to bottom, hsla(200, 100%, 50%, .3) 1px, transparent 1px);
    background-position: left -1px;
    background-repeat: repeat;
    background-size: 27px 27px;
}

.gridded body {
    box-shadow: 1px 0px 0px hsla(200, 100%, 50%, .3), -1px 0px 0px hsla(200, 100%, 50%, .3);
}

body {
    background-color: #fffbef;
    font-family: 'Source Sans Pro', sans-serif;
    border: solid 8px #c65635;
    color: #333;
    font-size: 1em;
    line-height: 1.5em;
    padding: 1.5em;
    margin: 0 auto;
    counter-reset: sidenote-counter;
}

@media (min-width: 749px) {
    body {
        font-size: 1.125em;
        /* 18px */
        line-height: 1.5em;
        padding: 1.5em;
        border-width: 15px;
    }
}

h1, h2, h3, h4, h5 {
    font-family: 'Source Sans Pro';
}

h1 {
    font-size: 2em;
    line-height: 1.5em;
    margin-top: 0.75em;
    margin-bottom: 0rem;
}

h2 {
    font-size: 1.3888888888888888em;
    line-height: 1.08em;
    margin-top: 1.08em;
    margin-bottom: 0em;
    font-style: italic;
}

h3 {
    font-size: 1em;
    line-height: 1.5em;
    margin-top: 1.5em;
    font-weight: bold;
    font-style: italic;
    margin-bottom: 0rem;
}

h2 code, h3 code { 
    font-style: normal; 
    background: none;
    border: none;
}

p, ul, ol, pre, table, blockquote {
    margin-top: 0em;
    margin-bottom: 1.5em;
}

ul ul, ol ol, ul ol, ol ul {
    margin-top: 0;
    margin-bottom: 0;
}

hr {
    border: 1px solid #ddd;
    /* margin: -1px 0; */
    margin: 3em 0;
}

b, strong, em, small, code {
    line-height: 1;
}

sup {
    line-height: 0;
    position: relative;
    vertical-align: baseline;
    top: -0.5em;
}

sub {
    bottom: -0.25em;
}

a:link, a:visited {
    color: inherit;
    text-decoration: none;
}

article a:link, article a:visited {
    color: #9f7433;
}

h1 a:link, h1 a:visited {
    color: #333;
}

a::after {
    content: '★';
    vertical-align: baseline;
    position: relative;
    top: -0.6em;
    font-size:0.6em;
    color: orange;
    font-style: normal;
}

h1 a::after, a.home::after, a.rss::after {
    content: none;
}

h2 a { text-decoration: none; }

footer.main, section.main, article {
    max-width: 40rem;
    margin: 0;
}

/* Larger than tablet */

@media (min-width: 750px) {
    header.main, footer.main, section.main, article {
        margin: 0 1em 0 10%;
        width: 65%;
    }
    header.main {
        width: 90%;
    }
}

header.main, footer.main {
    text-align: left;
}

header.main p {
    margin-bottom: 0;
}

header.main a.home {
    text-decoration: none;
    color: #700;
    text-transform: uppercase;
    letter-spacing: .1em;
    font-family: FiraMono, monospace;
    font-size: 1.3888888888888888em;
    line-height: 2.16em;
    margin-top: 1.08em;
    margin-bottom: 0em;
}

◊;header.main a.home:before {
◊;    float:left;
◊;    display:block;
◊;    background: url('css/lambda.png') no-repeat;
◊;    background-size: 100px;
◊;    width: 120px;
◊;    height: 120px;
◊;    content: ' ';
◊;    background-position: top left;
◊;}

.tagline {
    display: none;
}

@media only screen and (min-width: 541px) {
    .tagline {
        display: inline;
    }
}

nav {
    padding-bottom: 1.5em;
}

nav ul {
    padding: 0;
    margin: 0;
    height: 1.5em;
    line-height: 2em;
}

nav li {
    display: inline;
    font-style: italic;
}

nav li a:link {
    padding: .2em .5em; 
}

nav li::before      { content: '• '; }

nav li:last-child::before, nav li:first-child::before { content: ''; }

nav li:first-child a:link { padding-left: 0; }

nav li a:hover {
    /* border-color: #083; */
    color: #083;
}

footer.main {
    font-family: FiraMono, monospace;
    border-top: solid gray 1px;
    font-size: 0.666666667em;
    line-height: 2.25em;
    padding: 2.25em 0;
}

footer.main ul {
    list-style: outside none;
    padding-left: 0;
}

footer.main ul li {
    display: inline;
    padding-right: 1px;
    margin: 0;
}

footer.main ul li:after {
    content: "·";
    padding-left: 6px;
}

nav li a.rss {
    background: url('/css/feed.png') no-repeat 0 0.55em;
    padding-left: 18px;
    margin-left: 1em;
    color: gray;
}

a.rss:hover {
    border-color: #083;
    color: #083;
}

footer a.rss {
    background: url('/css/feed.png') no-repeat 2px 0;
    margin-left: 0;
    padding-left: 18px;
}

table.post-list {
    padding: 0;
    margin-top: 1.5em;
    width: 100%;
}

table.post-list td.date-col {
    width: 8em;
    font-family: FiraMono;
    font-size: 0.666666667em;
    line-height: 2.25em;
    text-align: right;
    vertical-align: top;
}

table.post-list td.post-col {
    vertical-align: top;
    padding-left: 1em;
}

article header {
    font-family: 'Source Sans Pro', "Helvetica Neue", Helvetica, Arial, sans-serif;
    margin-bottom: 1.5em;
}

article header h1 a {
    text-decoration: none;
}

article header h1 a:hover {
    background: #333;
    border-radius: 4px;
    color: #fefefe;
}

article header p, article header ul {
    text-transform: uppercase;
    font-size: 0.666666667em;
    line-height: 2.25em;
    letter-spacing: .1em;
}

article header p {
    margin-bottom: 0;
}

article header ul {
    height: 2.25em;
    padding: 0;
    margin: 0 0 2.25em 0;}

article header li {
    display: inline;
    text-transform: none;
    letter-spacing: 0;
    font-family: FiraMono;
    padding: 0 1em 0 0;
    margin: 0;
}

article header li a {
    text-decoration: none;
    background: #eee;
    border-radius: 3px;
}

span.newthought {
    font-variant: small-caps;
    font-size: 1.1em;
    letter-spacing: .06em;
}

.smallcaps {
    text-transform: uppercase;
    font-size: 90%;
    letter-spacing: 1px;
}

p + p.pause-before, ul + p.pause-before, ol + p.pause-before, blockquote + p.pause-before, table + p.pause-before, figure + p.pause-before {
    margin-top: 3.9em;
}

figure { margin: 1.5em 0; padding: 0; width: 100%; text-align: center;}

figure img {
    margin: 0 auto;
    max-width: 100%;
    border: solid #e0e0e0 1px;
}

figcaption {
    font-size: 0.75em;
    /* text-transform: uppercase; */
    /* letter-spacing: 1px; */
    margin-top: -0.5em;
    color: gray;
    text-align: left;
    font-style: italic;
}
blockquote:before {
    content: '“';
    font-size: 4em;
    font-weight: bold;
    color: #ddd;
    float: left;
    margin-left: -.7em;
    margin-top: .12em;
}

/* blockquote:after {
    content: '”';
    font-size: 4em;
    font-weight: bold;
    color: #ddd;
    float: right;
    margin-right: -.6em;
    margin-top: -.5em;
} */

blockquote.tweet:before, blockquote.retweet:before { content: none; }

blockquote.tweet {
    border: solid #9ae4e8 .5em; /* or 00aced */
    border-radius: 5px;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-weight: 300;
    padding: 1em;
    background: #fff;
}

blockquote.tweet p, .twContent { width: 100% }

blockquote.tweet img {
    max-width: 100%;
    border: solid #eee 1px;
    margin: 15px auto 0 auto;
}

blockquote.tweet footer {
    border-top: solid #999 1px;
    margin-top: 0.5625em;
    padding-top: 0.5625em;
    clear: both;
}

blockquote.tweet a:link { text-decoration: none; }

blockquote.tweet a:hover { text-decoration: underline; }

.twRealName { font-weight: bold; }

.twScreenName { color: gray; }

.twScreenName:before { content: " · "; color: #ccc; }

.twDecoration { display: none; }

.twContent {
    font-size: 1.3888888888888888em;
    line-height: 1.23em;
}

.twContent p { margin-bottom: 1.08em; }

.twContent p:last-child { margin-bottom: 0; }

.twTimeStamp {float: right; text-align: right; font-size: .75em;}

p.twRetweetMeta {margin-bottom: 0;}

blockquote.retweet {
    border: solid #ccc 1px;
    border-radius: 4px;
    font-size: 0.54em;
    line-height: 1.6em;
    width: 90%;
    margin: -1em 0 0 .8em;
    padding: 0.8em;
}

code {
    font-family: triplicate, monospace;
    background: #fafafa;
    border: solid #e0e0e0 1px;
    padding: 0 2px 0 2px;
    font-size: .8em;
    border-radius: 2px;
}

pre.code, article table {
    font-size: .75em;
    line-height: 1.6em;
    padding-top: 0.8em;
    padding-bottom: 0.8em;
    width: 100%;
}

div.listing-filename {
    font-family: triplicate, monospace;
    font-size: 0.75em;
    color: #555;
    border: solid lightgray 1px;
    background: #eee;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
    padding-left: 0.5em;
    padding-top: 2px;
}

pre.code {
    padding-left: 2.5%;
    overflow-x: scroll;
    margin: 2em 0;
    border: solid #cacaca 1px;
    font-family: triplicate, monospace;
    border-radius: 3px;
    background: #ffffef;
}

.listing-filename + pre.code {
    margin-top: -1px;
    padding-top: 0;
    border-top-left-radius: 0px;
    border-top-style: double;
}

@media (min-width: 749px) {
  pre.code { width: 130%; }
  table { max-width: 130%; }
}

.noun {
    font-style: italic;
    color: navy;
}

div.comment-box {
    background: #eee;
    border: dotted black 1px;
    border-radius: 3px;
    padding: 0 0.5em;
    margin-top: 1.5em;
    color: #555;
}

div.comment-box:last-of-type {
    margin-bottom: 1.5em;
}

.comment-meta {
    font-size: 0.666666667em;
    line-height: 2.25em;
    font-family: triplicate;
}

.comment-time {
    float: right;
    text-align: right;
}

.updateBox {
    background: white;
    position: relative;
    margin: 20px;
    padding: 0 0.5em;
    box-shadow:
        0 0 0 5px hsl(200, 100%, 60%),
        0 0 0 10px hsl(200, 100%, 70%),
        0 0 0 15px hsl(200, 100%, 80%),
        0 0 0 20px hsl(200, 100%, 90%);
}

.updateBox p:first-child { margin-bottom: 0em; }

dl.topic-list {
    margin: 20px auto;
    overflow: hidden;
    position: relative;
}

.topic-list dt {
    font-family: triplicate;
    color: navy;
    float: left;
    width: 23%;
    clear: both;
    padding: 0 2% 15px 0;
    position: relative;
}

.topic-list dt a { text-decoration: none; }

.topic-list dd {
    float: right;
    width: 72%;
    padding: 0 0 15px 3%;
    margin: 0;
}

.topic-list:before {
    content: "";
    width: 1px;
    position: absolute;
    border-left: 1px solid #999;
    top: 0;
    bottom: 0;
    left: 25%;
}

.topic-list dt:before {
    content: "";
    width: 30px;
    position: absolute;
    border-top: 1px solid #999;
    top: -5px;
    right: -15px;
}

.topic-list dt:after {
    content: "";
    width: 5px;
    height: 5px;
    background: #333;
    border: 1px solid #999;
    position: absolute;
    border-radius: 6px;
    top: -8px;
    right: -4px;
}

.sidenote, .marginnote {
    float: right;
    clear: right;
    margin-right: -35%;
    width: 30%;
    margin-top: .4rem;
    margin-bottom: 0;
    font-family: 'Source Sans Pro', "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: .75em;
    line-height: 1.6em;
    color: gray;
    vertical-align: baseline;
    position: relative;
}

.sidenote-number {
    counter-increment: sidenote-counter;
}

.sidenote-number:after, .sidenote:before {
    content: counter(sidenote-counter) " ";
    font-family: 'Source Sans Pro', "Helvetica Neue", Helvetica, Arial, sans-serif;
    position: relative;
    vertical-align: baseline;
}

.sidenote-number:after {
    content: counter(sidenote-counter);
    font-size: .75em;
    top: -0.5rem;
    left: 0.1rem;
}

.sidenote:before {
    content: counter(sidenote-counter) " ";
    top: -0.5rem;
}

input.margin-toggle {
    display: none;
}

label.sidenote-number {
    display: inline;
}

label.margin-toggle:not(.sidenote-number) {
    display: none;
}

@media (max-width: 750px) {
    label.margin-toggle {
        color: red;
    }
    label.margin-toggle:not(.sidenote-number) {
        display: inline;
    }
    .sidenote, .marginnote {
        display: none;
    }
    .margin-toggle:checked + .sidenote, .margin-toggle:checked + .marginnote {
        display: block;
        float: left;
        left: 1rem;
        clear: both;
        width: 95%;
        margin: 1rem 2.5%;
        vertical-align: baseline;
        position: relative;
    }
    label {
        cursor: pointer;
    }
    pre.code {
        width: 100%;
    }
    .table-caption {
        display: block;
        float: right;
        clear: both;
        width: 98%;
        margin-top: 1rem;
        margin-bottom: 0.5rem;
        margin-left: 1%;
        margin-right: 1%;
        vertical-align: baseline;
        position: relative;
    }
    div.table-wrapper, table, table.booktabs {
        width: 85%;
    }
    div.table-wrapper {
        border-right: 1px solid #efefef;
    }
    img {
        width: 100%;
    }
}

.latex-sub, .latex-sup { text-transform: uppercase;
                         font-size: smaller;
                         position: relative;
}

.latex-sub { top: 0.2rem;
             margin-left: -2px;
             margin-right: 0;
}

.latex-sup { top: -0.3rem;
             margin-left: -2px;
             margin-right: -1px;
             text-shadow: none;
}

.latex::selection, .latex span:not(.latex-sup)::selection {
    text-shadow: 0.03em 0 #b4d5fe, -0.03em 0 #b4d5fe, 0 0.03em #b4d5fe, 0 -0.03em #b4d5fe, 0.06em 0 #b4d5fe, -0.06em 0 #b4d5fe, 0.09em 0 #b4d5fe, -0.09em 0 #b4d5fe, 0.12em 0 #b4d5fe, -0.12em 0 #b4d5fe, 0.15em 0 #b4d5fe, -0.15em 0 #b4d5fe;
    background: #b4d5fe;
}

.latex::-moz-selection, .latex span:not(.latex-sup)::-moz-selection {
    text-shadow: 0.03em 0 #b4d5fe, -0.03em 0 #b4d5fe, 0 0.03em #b4d5fe, 0 -0.03em #b4d5fe, 0.06em 0 #b4d5fe, -0.06em 0 #b4d5fe, 0.09em 0 #b4d5fe, -0.09em 0 #b4d5fe, 0.12em 0 #b4d5fe, -0.12em 0 #b4d5fe, 0.15em 0 #b4d5fe, -0.15em 0 #b4d5fe;
    background: #b4d5fe;
}

◊;;;;;;;;;;;;;;;;;;;;;;;;

◊(define default-margin-left 0)
◊(define default-margin-right 0)
◊(define default-width 35)

#doc {
    margin-top: 6rem;
    margin-bottom: 6rem;
    ◊(make-css-kerning)
    font-family: SourceSansPro-Regular;
    color: #222;
    line-height: 1.4;
}

◊; don't want to use a #doc > * selector to apply default block metrics, because it will override block-level settings (because it is more “specific” in the CSS sense)

◊(define default-horiz-block-metrics (format "
    margin-left: ~arem;
    width: ~arem;
    margin-right: ~arem;" default-margin-left default-width default-margin-right))

◊|dept-tag|.◊|dept-class| {
    ◊|default-horiz-block-metrics|
    display: block;
    font-family: SourceSansPro-Bold, Cooper Black, Cooper Std, Rockwell Extra Bold, sans-serif;
    ◊(make-css-ot-features '("c2sc"))
    font-size: 1rem;
    border-bottom: 1px dashed gray;
}

◊|title-tag| {
    ◊|default-horiz-block-metrics|
    font-family: SourceSansPro-Regular;
    ◊(make-css-ot-features '("ss04"))
    font-size: 2rem;
    line-height: 1.1;
    width: 24rem;
    margin-top: 0.25rem;
    margin-bottom: 1.5rem;
}

◊|bigimage-tag|.◊|bigimage-class| {
    ◊|default-horiz-block-metrics|
    ◊(define overlap 4)
    width: ◊|(+ default-width overlap)|rem; 
    margin-left: ◊|(- default-margin-left overlap)|rem;
    margin-bottom: 1.5rem;
}

p {
  ◊|default-horiz-block-metrics|
  font-size: 1rem;
  margin-bottom: 0.8rem;
}

a.◊|extlink-class|:after {
    content: "\FEFF °"; 
    margin-left: 0.10em;
    font-size: 90%;
    top: -0.10em;
    color: #933;
}

◊|code-tag|.◊|code-class|, .◊|docs-class| {
  font-family: FiraMono-Regular, Consolas, Courier;  
  font-size: 0.85rem;
  background: #fafafa;
  padding: 0.1rem;
  ◊|link-hover-transition|
}

◊(define payload-color "#fdfdfd")

◊|subhead-tag|.◊|subhead-class| {
  ◊|default-horiz-block-metrics|
  ◊(make-css-ot-features '("ss04" "c2sc"))
  font-family: SourceSansPro-Bold, Cooper Black, Cooper Std, Rockwell Extra Bold, sans-serif;
  font-size: 1rem;
  line-height: 1.2;
  padding-top: 0.7rem;
  padding-bottom: 0.3rem;
}

◊|subhead-tag|.◊|foldable-class|:after {
  content: " +";
}

◊|payload-tag|.◊|payload-class| {
  ◊|default-horiz-block-metrics|
}

.◊|payload-class| p {
  ◊; because div.payload sets the margins
  margin-left: 0;
  width: inherit;
  margin-right: 0;  
}

em, .◊|deflink-class| {
  font-style: italic;
}

◊; the 'highlight' class name is hard-coded into Pygments, I’m afraid
.highlight {
    ◊|default-horiz-block-metrics|
    background: #fcfcfc;
    padding: 0.5rem;
    border-top: 1px solid #ebebeb;
    border-bottom: 1px solid #ebebeb;
    margin-bottom: 1.2rem;
}

◊|filename-tag|.◊|filename-class| {
  ◊|default-horiz-block-metrics|
  padding-bottom: 0.1rem;
  padding-top: 0.1rem;
  padding-left: 0.5rem;
  border-top-right-radius: 0.5rem;
  background: #f6f6f6;
  font-family: FiraMono-Regular, Consolas, Courier;
  font-size: 0.75rem;
  color: #666;
  position: relative;
  top: 1px;
}

.highlight .linenos {
    display: none;
}

.highlight pre {
    font-family: FiraMono-Regular, Consolas, Courier;
    font-size: 0.75rem;
    line-height: 1.35;
    margin-right: -2rem;
    white-space: pre-wrap;
}

◊|title-tag|+div.highlight pre {
  font-size: 67%;
}

◊; syntax colors adapted from Racket documentation
◊define[paren-color]{#888}
◊define[comment-color]{#c2741f}
◊define[keyword-color]{#07a}
◊define[name-color]{#444}
◊define[literal-color]{#275}

◊; styling classes for Pygments
.p { color: ◊|paren-color|;}
.c { color: #998; font-style: italic; } /* Comment */
.err { color: red; font-style: italic; } /* Error */
.o { color: #000; } /* Operator */
.cm { color: ◊|comment-color|; font-style: italic } /* Comment.Multiline */
.cp { color: ◊|comment-color|; font-style: italic } /* Comment.Preproc */
.c1 { color: ◊|comment-color|; font-style: italic } /* Comment.Single */
.cs { color: ◊|comment-color|; font-style: italic } /* Comment.Special */
.gd { color: #000; background-color: #ffdddd } /* Generic.Deleted */
.ge { color: #000; font-style: italic } /* Generic.Emph */
.gr { color: #a00; } /* Generic.Error */
.gh { color: #999; } /* Generic.Heading */
.gi { color: #000; background-color: #ddffdd } /* Generic.Inserted */
.go { color: #888; } /* Generic.Output */
.gp { color: #555; } /* Generic.Prompt */
.gs { } /* Generic.Strong */
.gu { color: #aaa; } /* Generic.Subheading */
.gt { color: #a00; } /* Generic.Traceback */
.k { color: ◊|keyword-color|; } /* Keyword */
.kc { color: ◊|keyword-color|; } /* Keyword.Constant */
.kd { color: ◊|keyword-color|; } /* Keyword.Declaration */
.kn { color: ◊|keyword-color|; } /* Keyword.Namespace */
.kp { color: ◊|keyword-color|; } /* Keyword.Pseudo */
.kr { color: ◊|keyword-color|; } /* Keyword.Reserved */
.kt { color: ◊|keyword-color|; } /* Keyword.Type */
.na { color: ◊|name-color|; } /* Name.Attribute */
.nb { color: ◊|keyword-color|; } /* Name.Builtin */
.nc { color: ◊|name-color|; } /* Name.Class */
.no { color: ◊|name-color|; } /* Name.Constant */
.nd { color: ◊|name-color|; } /* Name.Decorator */
.ni { color: ◊|name-color|; } /* Name.Entity */
.ne { color: ◊|name-color|; } /* Name.Exception */
.nf { color: ◊|name-color|; } /* Name.Function */
.nl { color: ◊|name-color|; } /* Name.Label */
.nn { color: ◊|name-color|; } /* Name.Namespace */
.nt { color: ◊|name-color|; } /* Name.Tag */
.nv { color: ◊|name-color|; } /* Name.Variable */
.ow { color: ◊|name-color|; } /* Operator.Word */
.w { color: #bbb; } /* Text.Whitespace */
.m { color: ◊|literal-color|; } /* Literal.Number */
.mf { color: ◊|literal-color|; } /* Literal.Number.Float */
.mh { color: ◊|literal-color|; } /* Literal.Number.Hex */
.mi { color: ◊|literal-color|; } /* Literal.Number.Integer */
.mo { color: ◊|literal-color|; } /* Literal.Number.Oct */
.s { color: ◊|literal-color|;} /* Literal.String */
.sb { color: ◊|literal-color|; } /* Literal.String.Backtick */
.sc { color: ◊|literal-color|; } /* Literal.String.Char */
.sd { color: ◊|literal-color|; } /* Literal.String.Doc */
.s2 { color: ◊|literal-color|; } /* Literal.String.Double */
.se { color: ◊|literal-color|; } /* Literal.String.Escape */
.sh { color: ◊|literal-color|; } /* Literal.String.Heredoc */
.si { color: ◊|literal-color|; } /* Literal.String.Interpol */
.sx { color: ◊|literal-color|; } /* Literal.String.Other */
.sr { color: ◊|literal-color|; } /* Literal.String.Regex */
.s1 { color: ◊|literal-color|; } /* Literal.String.Single */
.ss { color: ◊|literal-color|; } /* Literal.String.Symbol */
.bp { color: #999; } /* Name.Builtin.Pseudo */
.vc { color: #077; } /* Name.Variable.Class */
.vg { color: #077; } /* Name.Variable.Global */
.vi { color: #077; } /* Name.Variable.Instance */
.il { color: #099; } /* Literal.Number.Integer.Long */