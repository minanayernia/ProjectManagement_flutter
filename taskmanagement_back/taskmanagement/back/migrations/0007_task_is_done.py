# Generated by Django 4.0.3 on 2022-06-11 14:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('back', '0006_alter_boardlist_create_time_alter_task_create_time'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='is_done',
            field=models.BooleanField(default=1),
            preserve_default=False,
        ),
    ]
