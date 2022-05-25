# Content Security Policy and 304 Responses in Rails

This demo project is in support of the VectorLogic blog post on
[Content Security Policy and 304 Responses in Rails](https://www.vector-logic.com/blog/posts/content-security-policy-and-304-responses-in-rails).


To run the project:

```
> bin/rails s
```

With the server running you can view `Widgets` at:

```
http://localhost:3000/widgets/:id.
```

The simple project has been configured to use a `nonce`-based
allow-listing for inline scripts, with a fresh nonce randomly generated
on each request (see `config/initializers/content_security_policy.rb`).

This `nonce` ensures the inline script on the `Widget` page executes as
expected and throws a browser alert on page load.

The simple `WidgetsController` has been set up to return a `304` response for
any even-numbered `Widget`, provided the browser request has passed the
`If-Not-Modified` header to indicate that it already possesses a cached
version. In such circumstances our rails server will return an empty
`304` response, instructing the browser to use its cached version of the
page.

With this configuration, subsequent requests for an even-numbered widget
will generate a browser error due to the CSP being violated.
The reason for the violation is that the `304` response is returning a
new CSP header, which clobbers the existing header. This means the `nonce`
value associated with the `script` tags on the cached page will be stale
and deemed invalid by the browser.

I am not aware of any, but there may be cases where this is the desired
behaviour (?). But for our case the simplest solution is to remove the
`Content-Security-Policy` header from the `304` response. This can be
achieved by means of a custom middleware, which can be found at:

`lib/middlewares/remove_unneeded_content_security_policy.rb`

You can enable this middleware in the current probject by uncommenting
the annotated line at the bottom of the `config/application.rb` and
restarting your server.
