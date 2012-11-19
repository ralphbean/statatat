<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" type="text/css" href="/static/statatat.css" media="all"/>
    <script type="text/javascript">
      $.extend($.gritter.options, {
        position: 'bottom-right',
        fade_in_speed: 'medium',
        fade_out_speed: 500,
        time: 2500,
      });
    </script>
    <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-1943020-6']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script');
        ga.type = 'text/javascript';
        ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(ga, s);
      })();
    </script>
  </head>
  <body>
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand"
            href="http://statatat.ws">statatat.ws <small>(alpha)</small></a>
          <ul class="nav pull-right">
            <li class="${['', 'active'][request.on_stats]}">
            <a href="/stats">Stats</a>
            </li>
            %if request.user:
              <li class="${['', 'active'][request.on_profile]}">
              <a href="/${request.user.username}">
                Keys
              </a>
              </li>
              <li class="">
              <a href="#widgets_modal" data-toggle="modal">Widgets</a>
              </li>
            %endif
            <li class="">
            %if request.user:
              <form class="navbar-form pull-right" action="/logout" method="get">
                <input class="btn btn-info" type="submit" value="Sign out" />
              </form>
            %else:
              <form class="navbar-form pull-right" action="/login/github" method="post">
                <input class="btn btn-primary" type="submit" value="Sign in with Github" />
              </form>
            %endif
            </li>
          </ul>
        </div>
      </div>
    </div>

    <div class="vspace"></div>

    <div class="container">
      ${self.body()}
    </div>

    %if request.user:
      <div class="modal hide fade" id="widgets_modal" tabindex="-1" role="dialog" aria-labelledby="widgets_modal_label" aria-hidden="true">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h3 id="widgets_modal_label">Build an Embeddable Widget</h3>
        </div>
        <div class="modal-body">
          <div class="row">
            <span> <!-- class="span4"> -->
              <form id="widget-form" class="form-horizontal">
                <div class="control-group">
                  <label class="control-label">Width</label>
                  <div class="controls">
                    <div class="input-append">
                      <input id='width' class="input-mini right" value="400">
                      <span class="add-on">px</span>
                    </div>
                  </div>
                </div>

                <div class="control-group">
                  <label class="control-label">Height</label>
                  <div class="controls">
                    <div class="input-append">
                      <input id='height' class="input-mini right" value="55">
                      <span class="add-on">px</span>
                    </div>
                  </div>
                </div>

                <div class="control-group">
                  <label class="control-label">Duration</label>
                  <div class="controls">
                    <div class="input-append">
                      <input id='duration' class="input-mini right" value="1600">
                      <span class="add-on">ms</span>
                    </div>
                  </div>
                </div>

                <div class="control-group">
                  <label class="control-label">Buckets</label>
                  <div class="controls">
                    <div class="input-prepend">
                      <span class="add-on">#</span>
                      <input id='n' class="input-mini" value="100">
                    </div>
                  </div>
                </div>

                <div class="control-group">
                  <label class="control-label">Source Key</label>
                  <div class="controls">
                    % for source_key in reversed(request.user.active_source_keys):
                      <label class="radio">
                        <input type="radio"
                        name="options_source_keys"
                        id="topic"
                        value="${source_key.value}">
                        ${source_key.notes}
                      </label>
                    % endfor
                  </div>
                </div>
              </form>
            </span>
          </div>

          <div class="row"><h1 class="centered">⇣⇣⇣</h1></div>
          <div class="row"><h4 class="centered">Copy-and-paste</h4></div>
          <div class="row">
            <textarea id="copy-pasta" rows=3 readonly="readonly">${request.user.widget_link(source_key.value) | n}</textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        </div>
      </div>
    %endif

    ${moksha_socket.display() |n }

    <footer class="container-fluid">
    <p>Statatat is written by <a href="http://threebean.org">Ralph Bean</a>
      and is licened under the
      <a href="http://www.gnu.org/licenses/agpl-3.0.txt">AGPL</a>; the source
      code can be found
      <a href="http://github.com/ralphbean/statatat">on github.</a>
    </p>
    </footer>

    %if request.user:
    <script type="text/javascript">
    $(document).ready(function() {
      var prefix = window.location.protocol + "//" + window.location.host + "/widget/${request.user.username}/embed.js";
      $("form input").change(function (evt) {
        var values = {}, url = null;
        $("#widget-form input").each(function() {
            values[this.id] = $(this).val()
        });
        url = prefix + "?" + $.param(values);
        $("#copy-pasta").val(
          "<script type='text/javascript' src='" + url + "'><\/script>"
        );
      });
    });
    % endif
    </script>
  </body>
</html>
