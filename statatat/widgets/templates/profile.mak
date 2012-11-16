## -*- coding: utf-8 -*-
<div class="content">
  <div class="row">
    <span class="span8 offset2 profile-header">
      <div class="photo-64"><img src="${w.user.avatar_url}&s=64" /></div>
      <h1>
        ${w.user.username}
        <small>${w.user.name}</small>
      </h1>
    </span>
  </div>

  <div class="row">
    <span class="span8 offset2">
      <h1>API Keys</h1>
      <p>These are the keys to your car.  Try to keep them secret.</p>
      <p>Create a new <code>source_key</code> for each distinct data series
        you want to chart.
        ##You can include multiple <code>source_key</code> values as sources in a single chart.
        You'll need to copy-and-paste and
        use the <code>source_key</code> in any scripts you build that feed
        <a class="brand" href="#">statatat.ws</a>.  See
        <a href="http://statatat.readthedocs.org/en/latest/usage">
          the documentation</a> for how to use these.</p>

      <table class="table table-condensed table-hover table-striped">
        <tr>
          <th>Notes</th>
          <th>source_key</th>
          <th></th>
        </tr>
      </tr>
      % for key in reversed(w.user.source_keys):
        <tr>
          <td>${key.notes}</td>
          % if not key.revoked:
            <td><input
              class="input-xlarge"
              readonly="readonly"
              value="${key.value}"/>
            </td>
            <td>${w.make_revoke_button(key.value)}</td>
          % else:
            <td><input
              class="input-xlarge"
              disabled="disabled"
              value="${key.value}"/>
            </td>
            <td><small><em>(revoked)</em></small></td>
          % endif
        </tr>
      % endfor
    </table>
    <button href="#new_key_modal" data-toggle="modal" class="btn btn-primary">New Key</button>
  </span>
</div>

## TODO -- go back to work on github stuff later.  It was really slick.  :)
##<div class="vspace"></div>
##
##<div class="row">
##  <span class="span8 offset2">
##    <h1>"Batteries-included" Sources -- Github Repos</h1>
##    <p><a class="brand" href="#">statatat.ws</a> can add its hooks to your
##      github repositories automatically.  Anytime commits are pushed to a
##      repository where a hook is enabled, you can see them appear anywhere
##      your have realtime charts embedded.</p>
##    <table class="table table-condensed table-hover table-striped">
##      <tr>
##        <th>Name</th>
##        <th>Description</th>
##        <th>Language</th>
##        <th>Hook?</th>
##      </tr>
##      % for repo in w.gh_repos:
##        <tr>
##          <td>${repo.name}</td>
##          <td>${repo.description}</td>
##          <td>${repo.language}</td>
##          <td>${w.make_github_button(repo.name) | n}</td>
##        </tr>
##      % endfor
##    </table>
##  </span>
##</div>
##</div>

<div class="modal hide fade" id="new_key_modal" tabindex="-1" role="dialog" aria-labelledby="new_key_modal_label" aria-hidden="true">
  <form action="/key/new" method="POST">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h3 id="new_key_modal_label">New Service Key</h3>
    </div>
    <div class="modal-body">
      <input type="text" placeholder="Notes" id="notes" name="notes"/>
    </div>
    <div class="modal-footer">
      <button type="submit" class="btn btn-primary"
        aria-hidden="true">Create</button>
      <button class="btn"
        data-dismiss="modal" aria-hidden="true">Cancel</button>
    </div>
  </form>
</div>
