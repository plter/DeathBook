@auth.requires_membership('admin')
def groups_list():
    grid = SQLFORM.grid(
        db.auth_group,
        csv=False,
        deletable=False
    )
    return locals()


@auth.requires_membership('admin')
def users_list():
    grid = SQLFORM.grid(
        db.auth_user,
        csv=False,
        deletable=False
    )
    return locals()


@auth.requires_membership('admin')
def memberships():
    grid = SQLFORM.grid(
        db.auth_membership,
        csv=False,
        deletable=True
    )
    return locals()
