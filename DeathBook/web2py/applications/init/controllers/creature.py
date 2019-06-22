@auth.requires_membership('admin')
def souls_list():
    grid = SQLFORM.smartgrid(
        db.soul,
        formargs=dict(
            creature=dict(
                fields=['creature_name', 'lifetime', 'birthday', 'description', 'creature_state']
            ),
            life_log=dict(
                fields=['log_msg', 'log_content', 'add_lifetime', 'log_time']
            ),
        ),
        fields=dict(
            creature=[
                db.creature.creature_name,
                db.creature.lifetime,
                db.creature.birthday,
                db.creature.creature_state
            ]
        ),
        csv=False,
        deletable=False,
        details=False,
        orderby=dict(
            creature=~db.creature.birthday
        )
    )
    return locals()


@auth.requires_membership('admin')
def creature_list():
    grid = SQLFORM.smartgrid(
        db.creature,
        formargs=dict(
            life_log=dict(
                fields=['log_msg', 'log_content', 'add_lifetime', 'log_time']
            ),
            creature=dict(
                fields=['creature_name', 'lifetime', 'birthday', 'description', 'creature_state']
            )
        ),
        csv=False,
        deletable=False,
        details=False,
        orderby=dict(
            creature=~db.creature.birthday
        )
    )
    return locals()


@auth.requires_membership('admin')
def life_logs():
    grid = SQLFORM.grid(
        db.life_log,
        csv=False,
        deletable=False,
        details=False,
        create=False
    )
    return locals()


@auth.requires_membership('admin')
def list_of_recent():
    grid = db.executesql(
        "select soul,creature_name,lifetime,birthday,creature_state,total_add_lifetime,ifnull(total_add_lifetime,0)+lifetime-datediff(current_time,birthday) as remain_days from creature left join sum_lifetime on creature.id=sum_lifetime.creature where creature_state='alive' order by remain_days;",
        as_dict=True
    )
    return locals()
