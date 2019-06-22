db.define_table(
    'soul',
    Field('soul_name'),
    format="%(soul_name)s"
)

db.define_table(
    'creature',
    Field('soul', type='reference soul'),
    Field('creature_name', type='string'),
    Field('lifetime', type='integer'),
    Field('birthday', type='datetime'),
    Field('description', type='text'),
    Field('creature_state', type='string', requires=IS_IN_SET(('alive', 'dead'))),
    format="%(creature_name)s"
)

db.define_table(
    'life_log',
    Field('creature', type='reference creature'),
    Field('log_msg', type='string'),
    Field('log_content', type='text'),
    Field('add_lifetime', type='integer'),
    Field('log_time', type='datetime')
)
