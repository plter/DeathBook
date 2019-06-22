# -*- coding: utf-8 -*-
# this file is released under public domain and you can use without limitations

# ----------------------------------------------------------------------------------------------------------------------
# this is the main application menu add/remove items as required
# ----------------------------------------------------------------------------------------------------------------------

response.menu = [
    (T('Home'), False, URL('default', 'index'), [])
]

# ----------------------------------------------------------------------------------------------------------------------
# provide shortcuts for development. you can remove everything below in production
# ----------------------------------------------------------------------------------------------------------------------

if not configuration.get('app.production'):
    _app = request.application
    response.menu += [
        (T('Users'), False, "#", [
            (T('Groups'), False, URL('users', 'groups_list')),
            (T('Users'), False, URL('users', 'users_list')),
            (T('Memberships'), False, URL('users', 'memberships')),
        ]),
        (T('Creature'), False, "#", [
            (T('Souls'), False, URL('creature', 'souls_list')),
            (T('Creature'), False, URL('creature', 'creature_list')),
            (T('Life logs'), False, URL('creature', 'life_logs')),
            (T('List of recent'), False, URL('creature', 'list_of_recent')),
        ]),
    ]
