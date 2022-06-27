# Generated by Django 4.0.3 on 2022-04-16 09:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('back', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='person',
            name='about',
            field=models.CharField(blank=True, max_length=256, null=True),
        ),
        migrations.AlterField(
            model_name='person',
            name='birthday',
            field=models.DateField(null=True),
        ),
        migrations.AlterField(
            model_name='person',
            name='phoneNumber',
            field=models.CharField(blank=True, max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='person',
            name='pic',
            field=models.CharField(blank=True, max_length=256, null=True),
        ),
    ]
