from pyramid.view import view_config
from pyramid.security import authenticated_userid
from pyramid.httpexceptions import HTTPFound

import statatat.models as m
from statatat.widgets.graph import make_chart

import requests


# http://developer.github.com/v3/repos/hooks/
github_api_url = "https://api.github.com/hub"
github_events = [
    "push",
    #"issues",
    #"issue_comment",
    #"pull_request",
    #"gollum",
    #"watch",
    #"download",
    #"fork",
    #"fork_apply",
    #"member",
    #"public",
    #"status",
]


@view_config(route_name='new_key')
def new_key(request):
    username = authenticated_userid(request)
    if not username:
        # TODO -- raise the right status code
        return HTTPFound("/")

    user = m.User.query.filter_by(username=username).one()
    key = m.SourceKey(notes=request.POST.get('notes'))
    m.DBSession.add(key)
    user.source_keys.append(key)

    return HTTPFound(location="/" + username)


@view_config(route_name='home', renderer='index.mak')
def home(request):
    backend_key = "moksha.livesocket.backend"
    return {
        'chart': make_chart(request.registry.settings[backend_key]),
    }


@view_config(name='toggle', context=m.Repo, renderer='json')
def repo_toggle_enabled(request):
    repo = request.context
    repo.enabled = not repo.enabled
    data = {
        "access_token": request.session['token'],
        "hub.mode": ['unsubscribe', 'subscribe'][repo.enabled],
        # TODO -- use our own callback and not requestb.in
        # ... think over the best pattern for traversal first.
        "hub.callback": "http://statatat.ws/webhooks/github",
    }
    for event in github_events:
        data["hub.topic"] = "https://github.com/%s/%s/events/%s" % (
            repo.user.username, repo.name, event)
        # Subscribe to events via pubsubhubbub
        result = requests.post(github_api_url, data=data)

        # TODO -- handle errors more gracefully.
        assert(result.status_code == 204)

    return {
        'status': 'ok',
        'enabled': request.context.enabled,
        'repo': request.context.__json__(),
    }


@view_config(name='revoke', context=m.SourceKey, renderer='json')
def source_key_revoke(request):
    key = request.context
    key.revoked = True
    return key.__json__()

@view_config(route_name='docs', renderer='docs.mak')
def docs(request):
    return {}
