import tw2.core as twc
import statatat.models
import pyramid.threadlocal

from pygithub3 import Github
gh = Github()


class UserProfile(twc.Widget):
    template = "mako:statatat.widgets.templates.profile"
    user = twc.Param("An instance of the User SQLAlchemy model.")
    resources = [
        twc.JSLink(filename="static/profile.js"),
    ]

    # These get filled in just before the widget is displayed.
    gh_user = twc.Variable()
    gh_repos = twc.Variable()

    def prepare(self):
        """ Query github for some information before display """
        #self.gh_user = gh.users.get(self.user.username)
        # Sort repos alphabetically by name
        #self.gh_repos = sorted(
        #    gh.repos.list(self.user.username).all(),
        #    lambda x, y: cmp(x.name.lower(), y.name.lower()),
        #)

        # Add repos to our DB if we haven't seen them before.
        #existant_repos = [repo.name for repo in self.user.repos]

        # TODO -- fix this.  this is inefficient
        #for repo in self.gh_repos:
        #    if repo.name not in existant_repos:
        #        statatat.models.DBSession.add(statatat.models.Repo(
        #            user=self.user,
        #            name=repo.name,
        #            enabled=False,
        #        ))

    def make_github_button(self, repo_name):
        # TODO -- Can we use resource_url here?
        link = '/api/%s/%s/toggle' % (self.user.username, repo_name)
        click = 'onclick="subscribe(\'%s\')"' % link
        if self.user.repo_by_name(repo_name).enabled:
            cls, text = "btn-success", "Disable"
        else:
            cls, text = "btn-danger", "Enable"

        return "<button id='%s' class='btn %s' %s>%s</button>" % (
            repo_name, cls, click, text)

    def make_revoke_button(self, source_key):
        # TODO -- Can we use resource_url here?
        link = '/api/%s/source_key/%s/revoke' % (self.user.username, source_key)
        click = 'onclick="revoke(\'%s\')"' % link
        tmpl = '<button id="%s" class="btn btn-danger" %s>Revoke</button>'
        return tmpl % (source_key, click)
