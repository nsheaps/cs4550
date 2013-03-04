    In this folder you'll find all the source code for the site. In short, here is
    a quick breakdown of how the site works...
    
    .htaccess - contains all the routing info for better SEO
    include/  - contains all the PHP files that do work (creates header and footer)
    |- errorDocs/ - Contains the PHP files to make pretty error pages
    static/   - includes all the static files* so that it could be easily separated
    |            out into a CDN if need be
    |- css/   - contains the css files for the site.
    |- fonts/ - (not used) contains the font files for the site.
    |- html/  - Contains all the html files for the site
    |  |- errorDocs/ - contains the HTML for the error files
    |  |- venue/ - contains the html for the specific venues
    |- img/   - contains all the images for the site
    |- js/    - contains all the javascript for the site that isn't in an html file
    
    
    * The HTML isn't actually static. It has a bunch of PHP in it as well because I
      got lazy. The pages also aren't loaded in with ajax so it makes it a bit
      pointless with them on the same host.