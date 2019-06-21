@auth.requires_membership('admin')
def soul_list():
    grid = SQLFORM.smartgrid(
        db.soul,
        orderby=dict(
            soul=~db.soul.id,
            creature=~db.creature.birthday
        ),
        formargs=dict(
            creature=dict(
                fields=[
                    'creature_name', 'description', 'birthday', 'lifetime', 'creature_state'
                ]
            ),
            life_log=dict(
                fields=[
                    'log_msg', 'log_content', 'add_lifetime', 'log_time'
                ]
            )
        ),
        fields=dict(
            creature=[
                db.creature.creature_name,
                db.creature.birthday,
                db.creature.lifetime,
                db.creature.creature_state
            ]
        ),
        csv=False, deletable=False,
        editable=dict(
            soul=False,
            creature=True
        ),
        details=False,
        maxtextlength=300,
        user_signature=False
    )
    return locals()


@auth.requires_membership('admin')
def creatures_list():
    grid = SQLFORM.smartgrid(
        db.creature,
        create=dict(
            creature=False,
            life_log=True
        ),
        formargs=dict(
            life_log=dict(
                fields=[
                    'log_msg', 'log_content', 'add_lifetime', 'log_time'
                ]
            ),
            creature=dict(
                fields=[
                    'creature_name', 'description', 'birthday', 'lifetime', 'creature_state'
                ]
            ),
        ),
        fields=dict(
            life_log=[
                db.life_log.log_msg,
                db.life_log.log_content,
                db.life_log.add_lifetime,
                db.life_log.log_time
            ]
        ),
        orderby=dict(
            life_log=~db.life_log.log_time
        ),
        deletable=False, csv=False, editable=dict(
            creature=True
        ))
    return locals()


@auth.requires_membership('admin')
def list_of_recent():
    grid = db.executesql(
        'select *,lifetime-datediff(current_time,birthday)+total_add_lifetime as remain_days from creature,sum_creature_add_lifetime where creature.id=sum_creature_add_lifetime.creature and creature.creature_state="alive" order by remain_days limit 100;',
        as_dict=True
    )
    return locals()
