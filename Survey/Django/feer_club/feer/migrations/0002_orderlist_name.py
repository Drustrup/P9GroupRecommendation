# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-01-14 17:35
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('feer', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='orderlist',
            name='name',
            field=models.CharField(default='hej', max_length=512),
            preserve_default=False,
        ),
    ]