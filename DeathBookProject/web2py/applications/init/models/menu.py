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
        (T('Users'), False, '#', [
            (T('Groups'), False, URL('users', 'groups_list')),
            (T('Users'), False, URL('users', 'users_list')),
            (T('Memberships'), False, URL('users', 'memberships')),
        ]),
        (T('Creatures'), False, '#', [
            (T('Souls'), False, URL('creatures', 'soul_list')),
            (T('Creatures'), False, URL('creatures', 'creatures_list')),
            (T('List of recent'), False, URL('creatures', 'list_of_recent')),
        ]),
    ]
