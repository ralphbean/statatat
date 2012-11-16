from pyramid.view import view_config
from pyramid.httpexceptions import HTTPFound

import statatat.hub

from hashlib import md5

import moksha.hub.hub
import json

@view_config(name='github', request_method="POST",
             renderer='string', context="statatat.traversal.WebHookApp")
def github(request):
    """ Handle github webhook. """

    salt = "TODO MAKE THIS SECRET"

    if 'payload' in request.params:
        # TODO -- check the sha1 X-Hub-Signature to verify this is from github
        payload = request.params['payload']
        if isinstance(payload, basestring):
            payload = json.loads(payload)

        hub = statatat.hub.make_moksha_hub(request.registry.settings)

        topic_extractors = {
            'repo': lambda i: payload['repository']['url'],
            'repo_owner': lambda i: payload['repository']['owner']['email'],
            'author': lambda i: payload['commits'][i]['author']['email'],
            'committer': lambda i: payload['commits'][i]['committer']['email'],
        }
        for prefix, extractor in topic_extractors.items():
            for i, commit in enumerate(payload['commits']):
                topic = "%s.%s" % (
                    prefix, md5(salt + extractor(i)).hexdigest()
                )
                hub.send_message(topic=topic, message=commit)
    elif 'sysinfo' in request.params:
        sysinfo = request.params['sysinfo']
        if isinstance(sysinfo, basestring):
            sysinfo = json.loads(sysinfo)
        topic = "sysinfo"
        hub.send_message(topic=topic, message=sysinfo)
    else:
        raise NotImplementedError()

    return "OK"
