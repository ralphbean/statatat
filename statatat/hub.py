import moksha.hub.hub

_hub = None


def make_moksha_hub(settings):
    """ Global singleton. """
    global _hub
    if not _hub:
        _hub = moksha.hub.hub.MokshaHub(settings)

    return _hub
