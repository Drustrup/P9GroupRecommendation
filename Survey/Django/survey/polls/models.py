# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from __future__ import unicode_literals

from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=80)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=30)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Groups(models.Model):
    groupid = models.IntegerField(db_column='groupID', primary_key=True)  # Field name made lowercase.
    user1 = models.IntegerField(blank=True, null=True)
    user2 = models.IntegerField(blank=True, null=True)
    user3 = models.IntegerField(blank=True, null=True)
    user4 = models.IntegerField(blank=True, null=True)
    user5 = models.IntegerField(blank=True, null=True)
    user6 = models.IntegerField(blank=True, null=True)
    user7 = models.IntegerField(blank=True, null=True)
    user8 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'groups'


class Groups4(models.Model):
    groupid = models.IntegerField(db_column='groupID', primary_key=True)  # Field name made lowercase.
    user1 = models.IntegerField()
    user2 = models.IntegerField()
    user3 = models.IntegerField()
    user4 = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'groups4'


class Groups5(models.Model):
    groupid = models.IntegerField(db_column='groupID', primary_key=True)  # Field name made lowercase.
    user1 = models.IntegerField()
    user2 = models.IntegerField()
    user3 = models.IntegerField()
    user4 = models.IntegerField()
    user5 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'groups5'


class Groups6(models.Model):
    groupid = models.IntegerField(db_column='groupID', primary_key=True)  # Field name made lowercase.
    user1 = models.IntegerField()
    user2 = models.IntegerField()
    user3 = models.IntegerField()
    user4 = models.IntegerField()
    user5 = models.IntegerField(blank=True, null=True)
    user6 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'groups6'


class Groups7(models.Model):
    groupid = models.IntegerField(db_column='groupID', primary_key=True)  # Field name made lowercase.
    user1 = models.IntegerField()
    user2 = models.IntegerField()
    user3 = models.IntegerField()
    user4 = models.IntegerField()
    user5 = models.IntegerField(blank=True, null=True)
    user6 = models.IntegerField(blank=True, null=True)
    user7 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'groups7'


class Groups8(models.Model):
    groupid = models.IntegerField(db_column='groupID', primary_key=True)  # Field name made lowercase.
    user1 = models.IntegerField()
    user2 = models.IntegerField()
    user3 = models.IntegerField()
    user4 = models.IntegerField()
    user5 = models.IntegerField(blank=True, null=True)
    user6 = models.IntegerField(blank=True, null=True)
    user7 = models.IntegerField(blank=True, null=True)
    user8 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'groups8'


class Items(models.Model):
    itemid = models.IntegerField(db_column='itemID', primary_key=True)  # Field name made lowercase.
    item = models.CharField(max_length=300, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'items'


class Result(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    groupid = models.IntegerField(db_column='groupID', blank=True, null=True)  # Field name made lowercase.
    item1 = models.IntegerField(blank=True, null=True)
    item2 = models.IntegerField(blank=True, null=True)
    item3 = models.IntegerField(blank=True, null=True)
    item4 = models.IntegerField(blank=True, null=True)
    item5 = models.IntegerField(blank=True, null=True)
    item6 = models.IntegerField(blank=True, null=True)
    item7 = models.IntegerField(blank=True, null=True)
    item8 = models.IntegerField(blank=True, null=True)
    item9 = models.IntegerField(blank=True, null=True)
    item10 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'result'

class Surveys(models.Model):
    surveysid = models.IntegerField(db_column='surveysID', primary_key=True)  # Field name made lowercase.
    count = models.IntegerField()
    group1 = models.IntegerField()
    group2 = models.IntegerField()
    group3 = models.IntegerField()
    group4 = models.IntegerField()
    group5 = models.IntegerField()
    group6 = models.IntegerField()
    group7 = models.IntegerField()
    group8 = models.IntegerField()
    group9 = models.IntegerField()
    group10 = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'surveys'

class Userprefs(models.Model):
    userid = models.IntegerField(db_column='userID', primary_key=True)  # Field name made lowercase.
    item1 = models.IntegerField(blank=True, null=True)
    item2 = models.IntegerField(blank=True, null=True)
    item3 = models.IntegerField(blank=True, null=True)
    item4 = models.IntegerField(blank=True, null=True)
    item5 = models.IntegerField(blank=True, null=True)
    item6 = models.IntegerField(blank=True, null=True)
    item7 = models.IntegerField(blank=True, null=True)
    item8 = models.IntegerField(blank=True, null=True)
    item9 = models.IntegerField(blank=True, null=True)
    item10 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'userprefs'
