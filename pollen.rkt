#lang racket

(require racket/file
         setup/xref
         scribble/xref
         rackunit
         racket/string
         sugar/coerce
         pollen/setup       ; For current-poly-target
         pollen/file        ; get-markup-source
         txexpr
         pollen/tag         ; default-tag-function
         "util-date.rkt"
         "util-template.rkt"
         "pollen-local/polytag.rkt"
         "pollen-local/tags-html.rkt"
         "pollen-local/tags-pdf.rkt")

(provide string-split
         (all-from-out "util-date.rkt" "util-template.rkt")
         (all-from-out "pollen-local/tags-pdf.rkt"))
(provide (all-defined-out))


(module setup racket/base
    (provide (all-defined-out))
    (define poly-targets '(html pdf)))

(poly-branch-tag root)
    
(poly-branch-tag p)
(poly-branch-tag i)
(poly-branch-tag emph)
(poly-branch-tag b)
(poly-branch-tag strong)
(poly-branch-tag color c)
(poly-branch-tag ol)
(poly-branch-tag ul)
(poly-branch-tag item)
(poly-branch-tag sup)
(poly-branch-tag link url)
(poly-branch-tag blockquote)
(poly-branch-tag newthought)
(poly-branch-tag smallcaps)
(poly-branch-tag inline-math)
(poly-branch-tag center)

(poly-branch-tag section)
(poly-branch-tag subsection)

(poly-branch-tag index-entry entry)
(poly-branch-tag figure src (fullwidth #f) (has-print-version #f))
(poly-branch-tag margin-figure src (has-print-version #f))
(poly-branch-tag image src (has-print-version #f))

(poly-branch-tag margin-note)
(poly-branch-tag numbered-note)

; Note that because of the need to escape backslashes in LaTeX, you
; cannot use any other commands inside a ◊code tag
(poly-branch-tag code)
(poly-branch-tag noun)
(poly-branch-tag blockcode (filename ""))

(poly-branch-tag Latex)
(poly-branch-tag verse (title "") (italic #f))

#|
  ◊tweet and ◊retweet handle markup for embedded tweets. I use a Python script
  to generate the tags in my Pollen markup (github.com/otherjoel/blackbirdpy).
|#
(poly-branch-tag tweet)
(poly-branch-tag retweet)

(poly-branch-tag updatebox date-str)
(poly-branch-tag comment (authorlink ""))

; Our ◊table will support an optional argument specifying the text alignment for
; each column in the table: E.g. "llrc" means two left-aligned columns, a right-
; aligned column, and a center-aligned column (4 columns total).
(poly-branch-tag table (columns #f))
      
;(define (amazon product-id . contents)
;  (define affiliate-id "thloya-20")
;  (apply link (format "https://amzn.com/~a/?tag=~a" product-id affiliate-id) contents))

(require pollen/unstable/pygments pollen/decode)
(provide (all-defined-out) highlight)

(define filebox-tag 'div)
(define filebox-class "filebox")
(define filename-tag 'div)
(define filename-class "filename")
(define (filebox filename . xs)
  `(,filebox-tag ((class ,filebox-class)) (,filename-tag ((class ,filename-class) ,exclusion-mark-attr) ,(format "~a" filename)) ,@xs))

(define (filebox-highlight filename lang . xs)
  (filebox filename (apply highlight lang xs)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
`show-source` converts a source file to a displayable page.
|#
(define (show-source lang path)
  `(@ ,(title path) ,(highlight lang (file->string path))))

(define (show-source-link filename)
  (define url (format "~a.html" filename))
  (code (link url filename)))

#|
`root` is the main decoder for our Pollen markup.
|#
(define exclusion-mark-attr '(decode "exclude"))
;(define (root . items)
;  (decode `(decoded-root ,@items)
;          #:txexpr-elements-proc detect-paragraphs 
;          #:string-proc (compose1 smart-quotes smart-dashes)
;          #:exclude-tags '(style script pre)
;          #:exclude-attrs (list exclusion-mark-attr)))

#|
Tag functions used in the Pollen markup. Since I'm targeting HTML, I’ll convert my custom markup tags into standard HTML equivalents, which can then be styled with an external CSS file. (In practice, this isn't strictly necessary: web browsers don't care if you use nonstandard tags in your HTML, and I certainly don't either. But for this exercise, let’s pretend it matters.)

This “pollen.rkt” file makes variables available to the other files in the project. Thus, as we define the tag functions, we'll also define variables that will be handy when we get to the CSS. This is a rather overengineered approach for this tiny project, but on a large project, it's indispensable, because your CSS source can track the tag names in the original Pollen markup.
|#

(define code-tag 'span)
(define code-class "my-code")
;(define (code . elements)
;  `(,code-tag ((class ,code-class) ,exclusion-mark-attr) ,@elements))

(define dept-tag 'h3)
(define dept-class "dept")
(define (dept . elements)
  `(,dept-tag ((class ,dept-class)) ,@elements))

(define title-tag 'h1)
(define (title . elements)
  `(,title-tag ,@elements))

(define bigimage-tag 'div)
(define bigimage-class "bigimage")
(define (bigimage src)
  `(,bigimage-tag ((class ,bigimage-class)) (img ((src ,src)))))

(define extlink-class "ext")
(define (extlink url . texts)
  `(a ((href ,url)(class ,extlink-class)) ,@texts))  

;(define (link url . texts)
;  `(a ((href ,url)) ,@texts))

(define (gitlink repo . texts)
  `(span ((class ,code-class)) ,(apply link (format "http://github.com/~a" repo) texts)))

(define deflink-class "defined-term")
(define (deflink url . texts)
  `(span ((class ,deflink-class)) ,(apply extlink url texts)))

(define subhead-tag 'h3)
(define subhead-class "subhead")
(define (subhead . xs)
  `(,subhead-tag ((class ,subhead-class)) ,@xs))


#|
`folded` is a nice example of how Pollen can make implementation of HTML constructs simpler, and also keep those details out of the source.

`folded` creates two elements on the page: 1) a div with arbitrary content in it that's initially hidden, and 2) a subhead above that can be clicked to show or hide the div.

Moreover, because `folded` is implemented in Racket rather than HTML, we can use a neat trick: the `gensym` function will assign a unique ID to the div we show/hide, no matter how many times we use `folded` on the page. This generated ID is then used as input to a JavaScript function (because JavaScript is the only way of messing with the page after it's loaded).
|#
(define foldable-class "foldable")

(define (foldable-subhead . xs)
  `(,subhead-tag ((class ,(string-join (list subhead-class foldable-class)))) ,@xs))

(define payload-tag 'div)
(define payload-class "payload")

(define (folded title #:open [open #f] . xs)
  (define openness (if open "block" "none"))
  (define div-name (symbol->string (gensym)))
  `(@
    ,(foldable-subhead `(a ((href ,(format "javascript:toggle_div('~a')" div-name))) ,title))
    (,payload-tag ((style ,(format "display:~a;" openness))(id ,div-name) (class ,payload-class)) ,@(detect-paragraphs xs #:force? #t))))

(define (folded-open title . xs)
  (apply folded title #:open #t xs))

;(define filebox-tag 'div)
;(define filebox-class "filebox")
;(define filename-tag 'div)
;(define filename-class "filename")
;(define (filebox filename . xs)
;  `(,filebox-tag ((class ,filebox-class)) (,filename-tag ((class ,filename-class) ,exclusion-mark-attr) ,(format "~a" filename)) ,@xs))
;
;(define (filebox-highlight filename lang . xs)
;  (filebox filename (apply highlight lang xs)))

#|
`docs` creates links into Racket’s online documentation. This is fiddly because it’s specific to that system.
|#
(define docs-class "docs")

(define (docs module-path export . xs-in)
  (define xref (load-collections-xref))
  (define linkname (if (null? xs-in) (list export) xs-in))
  (define tag (xref-binding->definition-tag xref (list module-path (->symbol export)) #f))
  (define-values (path url-tag) (xref-tag->path+anchor xref tag #:external-root-url "http://pkg-build.racket-lang.org/doc/"))
  `(a ((href ,(format "~a#~a" path url-tag)) (class ,docs-class)) ,@linkname))