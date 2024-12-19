"""empty message

Revision ID: 6fef90d0b365
Revises: c6974146e229
Create Date: 2023-08-03 00:12:27.194796

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '6fef90d0b365'
down_revision = 'c6974146e229'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('users_moods_user_id_fkey', 'users_moods', type_='foreignkey')
    op.create_foreign_key(None, 'users_moods', 'users', ['user_id'], ['id'], ondelete='CASCADE')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'users_moods', type_='foreignkey')
    op.create_foreign_key('users_moods_user_id_fkey', 'users_moods', 'users', ['user_id'], ['id'])
    # ### end Alembic commands ###