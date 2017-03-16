# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-02-06 12:05
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('feer', '0010_auto_20160120_2232'),
    ]

    operations = [
        migrations.CreateModel(
            name='Profile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
        ),
        migrations.CreateModel(
            name='Rating',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('index', models.FloatField()),
                ('comment', models.TextField(default='')),
                ('beer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='feer.Beer')),
                ('profile', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='feer.Profile')),
            ],
        ),
        migrations.AddField(
            model_name='profile',
            name='reviews',
            field=models.ManyToManyField(through='feer.Rating', to='feer.Beer'),
        ),
        migrations.AddField(
            model_name='profile',
            name='user',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]