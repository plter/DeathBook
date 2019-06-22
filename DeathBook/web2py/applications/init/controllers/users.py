@auth.requires_membership('admin')
def groups_list():
    grid = SQLFORM.grid(
        db.auth_group,
        maxtextlength=100,
        deletable=False,
        csv=False,
        details=False,
        searchable=False
    )
    return locals()


@auth.requires_membership('admin')
def users_list():
    grid = SQLFORM.grid(
        db.auth_user,
        maxtextlength=100,
        deletable=False,
        csv=False,
        details=False,
        searchable=False
    )
    return locals()


@auth.requires_membership('admin')
def memberships():
    grid = SQLFORM.grid(
        db.auth_membership,
        maxtextlength=100,
        deletable=False,
        csv=False,
        details=False,
        searchable=False
    )
    return locals()
