<%inherit file="master.mak"/>

<div class="content">
  <div class="row">
    <span class="span10 offset1">
      <div class="hero-unit">
        <h1>Embeddable realtime charts.</h1>
            <p>Statatat provides embeddable, WebSocket-driven charts of
              whatever data you can stuff into it.</p>
            <!--
            <iframe
              src="http://player.vimeo.com/video/52403245?badge=0"
              width="100%" height="230" frameborder="0" webkitAllowFullScreen
              mozallowfullscreen allowFullScreen></iframe>
            -->
        </div>

      </div>
    </span>
  </div>

  <div class="row">
    <span class="span10 offset1">
      ${chart.display() |n}
    </span>
  </div>

  <div class="row">
    <span class="span2 offset1">
      <h2>Swank</h2>
      <p>By embedding your Statatat widget on your site, you can show off
        whatever activity to your friends.</p>
    </span>
    <span class="span3">
      <h2>Dashboard</h2>
      <p>Hosting a hackathon?  Throw together git post-receive hooks and a
        twitter scraper to make a conference for the big screen.
      </p>
      <div class="logo">
        <img style="height:80px" src="http://upload.wikimedia.org/wikipedia/commons/0/0d/BarCamp_logo.png"/>
      </div>
    </span>
    <span class="span3">
      <h2>Stack</h2>
      <p>Statatat talks <a href="http://www.zeromq.org">zeromq</a>, is written
        in <a href="http://python.org">Python</a>, and is built on top of
        <a href="http://mokshaproject.net/">Moksha</a> and <a
          href="http://pylonsproject.org">Pyramid</a>.  The widgets are
        rendered with <a href="http://d3js.org">d3js</a>.</p>
      <div class="logo">
        <img style="height:88px;"
        src="http://mokshaproject.github.com/mokshaproject.net/img/moksha-logo.png"/>
      </div>
    </span>
    <span class="span2">
      <h2>License</h2>
      <p>Statatat is licensed under the <a
          href="http://www.gnu.org/licenses/agpl-3.0.txt">AGPL</a> which means
        that the <a href="http://github.com/ralphbean/statatat">source code</a>
        must be available where the app is served.</p>
      <div class="logo">
        <img style="height:50px;" src="http://www.gnu.org/graphics/agplv3-155x51.png"/>
      </div>
    </span>
  </div>

</div>
