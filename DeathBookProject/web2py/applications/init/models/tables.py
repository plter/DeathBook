db.define_table(
    'soul',
    Field(
        'soul_name', type='string'
    ),
    format="%(soul_name)s"
)

db.define_table(
    'creature',
    Field('soul', type='reference soul'),
    Field('creature_name', type='string'),
    Field('description', type='text'),
    Field('birthday', type='datetime'),
    Field('lifetime', type='integer'),
    Field('creature_state', type='string', requires=IS_IN_SET(('alive', 'dead'))),
)

db.define_table(
    'life_log',
    Field('creature', type='reference creature'),
    Field('log_msg', type='string'),
    Field('log_content', type='text'),
    Field('add_lifetime', type='integer'),
    Field('log_time', type='datetime')
)
