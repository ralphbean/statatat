from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound, HTTPForbidden, HTTPBadRequest

import statatat.models as m
import statatat.hub

from hashlib import md5


@view_config(name='source_key', request_method="POST",
             renderer='string', context="statatat.traversal.WebHookApp")
def source_key(request):
    """ Handle source_key driven webhook.

    Hit this like::

        $ curl http://localhost:6543/webhooks/source_key \
            -d username=ralphbean \
            -d source_key=a9013f2c4b9bb6b16c4dee212d5a2c39
    """

    if not 'username' in request.params:
        return HTTPBadRequest("no username")

    if not 'source_key' in request.params:
        return HTTPBadRequest("no source_key")

    username = request.params['username']
    source_key = request.params['source_key']
    user = m.User.query.filter_by(username=username).one()

    user_source_keys = user['source_key']
    if not source_key in user_source_keys:
        raise HTTPForbidden()

    hub = statatat.hub.make_moksha_hub(request.registry.settings)

    topic = request.params['source_key']
    message = request.params.get('message', dict(value=1))
    hub.send_message(topic=topic, message=message)
    return "OK"
