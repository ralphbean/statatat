<%inherit file="master.mak"/>

<div class="content">
  <div class="row">
    <span class="span6 offset3">
      <h2>Questions?</h2>
      <p>Please read these docs first, but if you have questions or think you've
        found a bug, please take a quick look at the <a
          href="http://github.com/ralphbean/statatat/issues">list of current
          issues</a> first, and then please file <a
          href="https://github.com/ralphbean/statatat/issues/new">
          a new issue</a>.
      </p>
      <h2>Feeding Statatat</h2>
      <p>The central object in Statatat is the <code>source_key</code>.  It
        is a routing code that helps distinguish data streams from one
        another.  When you post data points to statatat, they must be
        accompanied by a <code>source_key</code>.  When you create a
        widget, it knows what data to chart by which <code>source_key</code>
        you provide it.</p>
      <p>You can create as many keys as you want from your
        % if request.user:
          <a href="/${request.user.username}">Profile</a>
        % else:
          Profile
        % endif
        and revoke any keys that you think may have fallen into the wrong
        hands.  When creating a key, you'll be asked for some "Notes" just to
        describe what you'll be using it for.  It's only to help you remember if
        you need to check back for some reason and isn't significant in any
        other way.</p>

      <p>With your <code>username</code> and a <code>source_key</code> you can
        feed data to your statatat account.  This is done by making HTTP POST
        requests to <code>http://statatat.ws/webhooks/source_key</code>.  The
        server will be expecting your <code>username</code> and
        <code>source_key</code> there.  For example, with curl:
      </p>
      <script src="https://gist.github.com/4108721.js?file=with-curl.sh">
      </script>
      <p>Or with python (using the python <a
          href="http://docs.python-requests.org">requests</a> module):</p>
      <script src="https://gist.github.com/4108721.js?file=with-python.py">
      </script>

      <h2>Creating a widget</h2>
      <p>"Widgets" are standalone UI components.  They don't poll for new data
        with AJAX, but establish a WebSocket connection with <a
          href="http://statatat.ws">http://statatat.ws</a>.
        Currently, statatat
        only provides charts of one kind.  In the future, we hope to implement
        many more.</p>
      <p>To create a new embeddable widget,
        % if request.user:
          click on the <a href="#widgets_modal" data-toggle="modal">Widgets</a>
        % else:
          login and click on the Widgets
        % endif
        item in the navigation menu at the top of the page.  You will be
        presented with a widget creation dialog containing a number of options:
      </p>
      <ul>
        <li><code>width</code> - the desired width of the widget in pixels.</li>
        <li><code>height</code> - the desired height of the widget in pixels.</li>
        <li><code>duration</code> - the duration in milliseconds of one
        "bucket" in the time series.</li>
        <li><code>n</code> - the number of "buckets" the chart should
        model.</li>
        <li><code>source_key</code> - which data stream the widget should
        connect to.
      </ul>
      <p><code>width</code> and <code>height</code> are self explanatory.  We
        currently restrict you to specifying width and height in pixels only
        (and not in percentages, for instance).  In the future we'd like to
        open it up to be more flexible.
      </p>
      <p><code>duration</code> and <code>n</code> are not so obvious.  Think
        of <code>n</code> (the number of "buckets") as the
        <em>resolution</em> of your graph.  The higher <code>n</code> is, the
        more <em>fine-grained</em> and jagged your graph will appear.  A lower
        <code>n</code> will make a smoother, more rolling graph.</p>
      <p><code>duration</code> is the duration of a single "bucket" (specified
        in milliseconds).  If you have a <code>duration</code> of 1000
        milliseconds, then the height of each datapoint on your chart will
        be the number of POSTs received during each second.  If you have a
        <code>duration</code> of 1000 ms and an <code>n</code> value of 10,
        then your chart's domain will be from the present back 10 seconds into
        the past.  Just for one more example, if you have a
        <code>duration</code> of 2000 and an <code>n</code> value of 120, then
        your chart will show data from the past 4 minutes.</p>

      <p>Embedding your chart is easy; just copy and paste from the widget
        creation dialog into your website of choice.  For example:
      </p>
      <script src="https://gist.github.com/4108721.js?file=example-index.html"></script>

      <p>The widget should be injected <em>in-place</em> and shouldn't
        interfere with any of your other CSS or javascript (at least.. we aim
        for that).
      </p>
    </span>
  </div>
</div>
