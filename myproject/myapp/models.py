from django.db import models

class Room(models.Model):
    room_number = models.CharField(max_length=5)
    is_available = models.BooleanField(default=True)