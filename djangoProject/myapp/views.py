from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Room

@api_view(['GET'])
def available_rooms(request):
    rooms = Room.objects.filter(is_available=True)
    data = [{'room_number': room.room_number} for room in rooms]
    return Response(data)